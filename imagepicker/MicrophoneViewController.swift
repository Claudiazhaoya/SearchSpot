/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit
import SpeechToTextV1

class MicrophoneViewController: UIViewController {

    var speechToText: SpeechToText!
    var speechToTextSession: SpeechToTextSession!
    var isStreaming = false
    
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        microphoneButton.layer.masksToBounds = true
        microphoneButton.layer.cornerRadius = microphoneButton.frame.width/2
//        let width = UIScreen.main.bounds.size.width
//        let height = UIScreen.main.bounds.size.height
//        
//        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
//        imageViewBackground.image = UIImage(named: "microphone")
//        
        // you can change the content mode:
//        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "microphone")!)
        self.view.contentMode = UIViewContentMode.scaleAspectFill

        speechToText = SpeechToText(
            username: Credentials.SpeechToTextUsername,
            password: Credentials.SpeechToTextPassword
        )
        speechToTextSession = SpeechToTextSession(
            username: Credentials.SpeechToTextUsername,
            password: Credentials.SpeechToTextPassword
        )
    }
    
    @IBAction func didPressMicrophoneButton(_ sender: UIButton) {
        streamMicrophoneBasic()
    }
    
    /**
     This function demonstrates how to use the basic
     `SpeechToText` class to transcribe microphone audio.
     */
    public func streamMicrophoneBasic() {
        if !isStreaming {
            
            // update state
            microphoneButton.backgroundColor = UIColor.darkGray
//            microphoneButton.adjustsImageWhenHighlighted = false
//            microphoneButton.setTitle("Stop Microphone", for: .normal)
            isStreaming = true
            
            // define recognition settings
            var settings = RecognitionSettings(contentType: .opus)
            settings.continuous = true
            settings.interimResults = true
            
            // define error function
            let failure = { (error: Error) in print(error) }
            
            // start recognizing microphone audio
            speechToText.recognizeMicrophone(settings: settings, failure: failure) {
                results in
                print("Hey, I am accurate!")
                print("result: \(results.bestTranscript)")
                self.textView.text = results.bestTranscript
            }
            
        } else {
            
            // update state
            microphoneButton.backgroundColor = UIColor.lightGray
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpID") as! PopUpViewController
            self.addChildViewController(popOverVC)
            popOverVC.voiceKey = textView.text!.removingWhitespaces()
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
//            microphoneButton.setTitle("Start Microphone", for: .normal)
            isStreaming = false
            
            // stop recognizing microphone audio
            speechToText.stopRecognizeMicrophone()
            microphoneButton.backgroundColor = UIColor.lightGray
        }
    }
    
    /**
     This function demonstrates how to use the more advanced
     `SpeechToTextSession` class to transcribe microphone audio.
     */
    public func streamMicrophoneAdvanced() {
        if !isStreaming {
            
            // update state
            microphoneButton.setTitle("Stop Microphone", for: .normal)
            isStreaming = true
            
            // define callbacks
            speechToTextSession.onConnect = { print("connected") }
            speechToTextSession.onDisconnect = { print("disconnected") }
            speechToTextSession.onError = { error in print(error) }
            speechToTextSession.onPowerData = { decibels in print(decibels) }
            speechToTextSession.onMicrophoneData = { data in print("received data") }
            speechToTextSession.onResults = { results in self.textView.text = results.bestTranscript }
            
            // define recognition settings
            var settings = RecognitionSettings(contentType: .opus)
            settings.continuous = true
            settings.interimResults = true
            
            // start recognizing microphone audio
            speechToTextSession.connect()
            speechToTextSession.startRequest(settings: settings)
            speechToTextSession.startMicrophone()
            
        } else {
            
            // update state
            microphoneButton.setTitle("Start Microphone", for: .normal)
            isStreaming = false
            
            // stop recognizing microphone audio
            speechToTextSession.stopMicrophone()
            speechToTextSession.stopRequest()
            speechToTextSession.disconnect()
        }
    }
}
