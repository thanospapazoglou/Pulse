
<br />
<p align="center">
<img src="images/AppIconShadow.png" alt="Logo" width="80" height="80">
<h1 align="center">Pulse ❤️</h1>
</p>

The **Pulse** app uses the back main wide camera of your iPhone and measures your heart rate pulse.  

## 🤔 How it works?
1. We initialize a Video Capture object from the back camera with a frame of 300x300 and 30fps.
2. We extract the `CMSampleBuffer` from every frame with the protocol of `AVCaptureVideoDataOutputSampleBufferDelegate`.
3. From this frame, we get the [RGB](https://en.wikipedia.org/wiki/RGB_color_model) (Red Green Blue) mean values of every pixel.
4. We convert the RGB values to [HSV](https://en.wikipedia.org/wiki/HSL_and_HSV) (Hue Saturation Value), in order to make the model work.
5. We isolate the **Hue** component and process it with a simple **[Band-pass filter](https://en.wikipedia.org/wiki/Band-pass_filter)**.  
The filter just removes any DC component and any high frequency noise from the value.
6. We create a simple `Timer()` with `TimeInterval` at one (1) second and get the **average value** of the pulse's periods.
7. Then, if we devide that average value by **60**, we have our heart rate pulse.  
**60** because the **[heart rate pulse](https://en.wikipedia.org/wiki/Heart_rate)** is measured in bpm<sub>s</sub> (Beats of the heart per minute).  

When extracting the HSV values we increment a `validFrameCounter` for identifying if the index finger is placed correctly in the back camera.
If it is above 60 then we process the Hue value with the filter.  
The pulse detector gives us a threshold for pulse to -60 in order to know when to display an error message or the actual bpm value.

## ⚙️ Requirements
- iOS 12.0+
- Xcode 10.0+

## 📲 Installation
1. Download the project and build it with your development team.  
2. Congratulations 🎉!

## 🙏 Contribution
Special thanks to **Gurpreet Singh** from **Pubnub**<sub>(read that carefully 😅)</sub> for creating the Filter and PulseDetector in Obj-C.

## 📃 License
[MIT](https://choosealicense.com/licenses/mit/)
