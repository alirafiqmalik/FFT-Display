function readSineWaveData(src, ~)

Fs = 2000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 256;             % Length of signal
% Read the ASCII data from the serialport object.
data = readline(src);
% Convert the string data to numeric type and save it in the UserData
% property of the serialport object.
src.UserData.Data(end+1) = str2double(data);
% Update the Count value of the serialport object.
src.UserData.Count = src.UserData.Count + 1;
% If 1001 data points have been collected from the Arduino, switch off the
% callbacks and plot the data.
if src.UserData.Count > 255
    %configureCallback(src, "off");
    Y = fft(src.UserData.Data);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    %plot(src.UserData.Data);
    f = Fs*(0:(L/2))/L;
    plot(f,P1) 
    title("Single-Sided Amplitude Spectrum of X(t)")
    xlabel("f (Hz)")
    ylabel("|P1(f)|")
    src.UserData.Count = 0;
    src.UserData.Data = [];
    

end
    
end