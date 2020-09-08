

function M=fftDenoiseImage(Image)

        K=fft2(Image);
        K=fftshift(K);
%         K(1022:1026,1:1022)=0;
%         K(1022:1026,1026:2048)=0;
        K(1737:1743,1:1737)=0;
        K(1737:1743,1743:3481)=0;
        K=ifftshift(K);
        M=uint16(real(ifft2(K)));

end