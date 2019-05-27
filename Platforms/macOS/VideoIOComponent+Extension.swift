import AVFoundation

extension VideoIOComponent {
    func attachScreen(_ screen: AVCaptureScreenInput?) {
        output = nil
        guard screen != nil else {
            input = nil
            return
        }
        lockQueue.sync {
            mixer?.session.beginConfiguration()
            input = screen
            mixer?.session.addOutput(output)
            output.setSampleBufferDelegate(self, queue: lockQueue)
            mixer?.session.commitConfiguration()
            if mixer?.session.isRunning ?? false {
                mixer?.session.startRunning()
            }
        }
    }
}
