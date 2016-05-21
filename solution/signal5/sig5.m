addpath('../../toolbox');
load('../../material/Signal5');
clf

pilot = 'B';
prefix_len = 16;
symbol_len = 4*prefix_len;
freq_off = 0.831832859366377;

sig = resample(Signal, 40007,40000);
sig = sig(19:end);

sig = sig .* exp(-1j*2*pi*freq_off/64*(1:size(sig,2)));

fft_sig = shape_ofdm(sig, symbol_len, prefix_len);

%plot pilot phases
plot(angle(fft_sig(5,:)));
hold on
plot(angle(fft_sig(13,:)));
plot(angle(fft_sig(21,:)));
plot(angle(fft_sig(29,:)));
hold off

%plot(abs(fft_sig(5,:)));

fft_sig = remove_unused(fft_sig, symbol_len);
fft_sig = remove_pilot(fft_sig, pilot, symbol_len);

% plot constellation
for i = 1:48
    plot(fft_sig(i,:),'*')
    hold on
end

syms = pskdemod(fft_sig, 8, -0.18+pi/4*2);
text = ascii_decoding(syms, 8)

hex = ['42';'3a';'20';'57';'65';'6c';'6c';'2c';'20';'49';'27';'6d';'20';'67';'6f';'6e';'6e';'61';'20';'67';'65';'74';'20';'6f';'75';'74';'20';'6f';'66';'20';'62';'65';'64';'20';'65';'76';'65';'72';'79';'20';'6d';'6f';'72';'6e';'69';'6e';'67';'2e';'2e';'2e';'20';'62';'72';'65';'61';'74';'68';'65';'20';'69';'6e';'20';'61';'6e';'64';'20';'6f';'75';'74';'20';'61';'6c';'6c';'20';'64';'61';'79';'20';'6c';'6f';'6e';'67';'2e';'20';'54';'68';'65';'6e';'2c';'20';'61';'66';'74';'65';'72';'20';'61';'20';'77';'68';'69';'6c';'65';'20';'49';'20';'77';'6f';'6e';'27';'74';'20';'68';'61';'76';'65';'20';'74';'6f';'20';'72';'65';'6d';'69';'6e';'64';'20';'6d';'79';'73';'65';'6c';'66';'20';'74';'6f';'20';'67';'65';'74';'20';'6f';'75';'74';'20';'6f';'66';'20';'62';'65';'64';'20';'65';'76';'65';'72';'79';'20';'6d';'6f';'72';'6e';'69';'6e';'67';'20';'61';'6e';'64';'20';'62';'72';'65';'61';'74';'68';'65';'20';'69';'6e';'20';'61';'6e';'64';'20';'6f';'75';'74';'2e';'2e';'2e';'20';'61';'6e';'64';'2c';'20';'74';'68';'65';'6e';'20';'61';'66';'74';'65';'72';'20';'61';'20';'77';'68';'69';'6c';'65';'2c';'20';'49';'20';'77';'6f';'6e';'27';'74';'20';'68';'61';'76';'65';'20';'74';'6f';'20';'74';'68';'69';'6e';'6b';'20';'61';'62';'6f';'75';'74';'20';'68';'6f';'77';'20';'49';'20';'68';'61';'64';'20';'69';'74';'20';'67';'72';'65';'61';'74';'20';'61';'6e';'64';'20';'70';'65';'72';'66';'65';'63';'74';'20';'66';'6f';'72';'20';'61';'20';'77';'68';'69';'6c';'65';'2e'];
hex = reshape(hex,[],2);
hex = hex2dec(hex);
text2 = char(hex)'