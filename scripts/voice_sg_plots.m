#!/usr/bin/octave -qf
% Writes the long and short plots of the spectrogram
if (nargin != 3),
    error('Missing arguments: path N_fft, Hop');
end
pkg load signal
args=argv();
[path, N_fft,Hop]=args{:};
N_fft = str2num(N_fft);
Hop = str2num(Hop);
[x,fs]=wavread(path);
[S,F,T]=specgram(x,N_fft,fs,N_fft,N_fft-Hop);
handle=imagesc(flipud(log10(abs(S)/10)));
L=size(S,2);
ax=gca;
set(ax,'ytick',[0:N_fft/8:N_fft/2]);
set(ax,'yticklabel', ...
    cellfun(@num2str, ...
        num2cell(round((N_fft/2-get(ax,'ytick'))/N_fft*fs)), ...
        'UniformOutput',false));
set(ax,'xtick',[0:L/4:L]);
set(ax,'xticklabel', ...
    cellfun(@num2str, ...
        num2cell(get(ax,'xtick')*Hop/44100), ...
        'UniformOutput',false));
axis("square");
savpath=sprintf('%s_%d_%d.%s',cell2mat( ...
        ostrsplit( cell2mat(ostrsplit(path,'/')(end)), '.')(1)),
        N_fft,Hop,'eps');
ylabel('Frequency (Hz)');
xlabel('Time (s)');
title( ...
    sprintf('Log Magnitude Spectrogram\n(Window Size: %d Hop Size: %d)', ...
        N_fft,Hop));
print(savpath,'-depsc2');
