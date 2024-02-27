import cv2
from pykuwahara import kuwahara

image = cv2.imread('/home/inkeaton/Immagini/Sfondi/Nightmare\ Eyes.png')

filt1 = kuwahara(image, method='mean', radius=30)
filt2 = kuwahara(image, method='gaussian', radius=30)    # default sigma: computed by OpenCV

cv2.imwrite('lena-kfilt-mean.jpg', filt1)
cv2.imwrite('lena-kfilt-gaus.jpg', filt2)