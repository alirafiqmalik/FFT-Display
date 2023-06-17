clc;clear all;close all

%serialportlist("available")
arduinoObj = serialport("/dev/ttyUSB1",115200)
configureTerminator(arduinoObj,"LF");
flush(arduinoObj);
arduinoObj.UserData = struct("Data",[],"Count",1)
configureCallback(arduinoObj,"terminator",@readSineWaveData);