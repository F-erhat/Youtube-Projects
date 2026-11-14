# Youtube_DIY_Projeler
# 🟢 Arduino Ultrasonic Radar

<p align="center">
  <strong>Real-Time Radar Visualization with Arduino & Processing</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Arduino-00979D?style=for-the-badge&logo=arduino&logoColor=white" />
  <img src="https://img.shields.io/badge/Software-Processing-006699?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Sensor-HC--SR04-green?style=for-the-badge" />
</p>

---

## 📡 About the Project

This project is a real-time radar visualization system built using **Arduino** and the **HC-SR04 ultrasonic distance sensor**.

It receives angle and distance information from Arduino and visualizes the data on a computer screen using Processing.

The radar interface displays detected objects, scanning movement, distance indicators, and real-time measurements.

## ✨ Features

| Feature | Description |
|---|---|
| 📡 Real-Time Radar | Live radar visualization |
| 📏 Distance Measurement | HC-SR04 ultrasonic sensor |
| 🔄 Angle Tracking | Displays the current scanning angle |
| 🔴 Object Detection | Detected objects are highlighted in red |
| 🟢 Scanning Line | Green radar scanning indicator |
| 📐 Detection Range | 40 cm visualization range |
| 🔌 Serial Communication | Arduino-to-Processing data transfer |

## 🧰 Requirements

Before starting, make sure you have the following components and software:

**Hardware**
- Arduino board
- HC-SR04 ultrasonic sensor
- USB cable

**Software**
- Arduino IDE
- Processing

## ⚙️ Installation & Setup

### 1. Install the Required Software

Download and install:

- [Arduino IDE](https://www.arduino.cc/en/software)
- [Processing](https://processing.org/download)

Make sure both applications are installed and working correctly.

### 2. Check the Processing Serial Library

The project requires the `processing.serial.*` library.

Make sure the Serial library is available in Processing.

If it is missing, install it through:

`Sketch → Import Library → Add Library`

Search for **Serial** and install the appropriate library.

### 3. Connect Your Arduino

Connect your Arduino board to your computer using a USB cable.

Open Arduino IDE and check which COM port is assigned to your board.

### 4. Configure the COM Port

<blockquote>
⚠️ <strong>Important:</strong> The default serial port in this project is <code>COM4</code>.
</blockquote>

Make sure your Arduino is actually connected to COM4.

If your Arduino uses a different port (such as COM3, COM5, or COM6), update the serial port setting in the Processing project accordingly.

**The COM port specified in Processing must match the port assigned to your Arduino.**

Also, close Arduino IDE's Serial Monitor and Serial Plotter before running Processing. Otherwise, the serial port may already be in use.

### 5. Run the Project

After completing the installation and checking your connections:

1. Open the Processing project.
2. Verify the Serial library installation.
3. Check the COM port configuration.
4. Run the Processing sketch.

If everything is configured correctly, the radar interface will open and display incoming sensor data.

## 🛠️ Troubleshooting

<details>
<summary><strong>❌ Processing cannot connect to Arduino</strong></summary>

- Make sure Arduino is connected to your computer.
- Check the assigned COM port.
- Verify that the COM port in Processing matches your Arduino.
- Close Arduino IDE Serial Monitor and Serial Plotter.

</details>

<details>
<summary><strong>📚 Serial library error</strong></summary>

Make sure the Processing Serial library is installed correctly.

</details>

<details>
<summary><strong>📡 No objects are displayed</strong></summary>

- Check the HC-SR04 sensor connections.
- Make sure Arduino is receiving sensor data.
- Verify serial communication settings.
- Remember that the visualization range is limited to 40 cm.

</details>

---

## 🤝 Contributing

Suggestions, improvements, and contributions are welcome!

Feel free to explore the project and share your ideas.

---

<p align="center">
  <strong>⚡ Mühendislik Üssü</strong>
  <br />
  <em>Learn. Experiment. Build. Improve!</em>
</p>
Projeyi geliştirmek, iyileştirmek veya yeni özellikler eklemek isteyen herkese açığım.

Önerilerinizi ve geliştirmelerinizi paylaşabilirsiniz.
