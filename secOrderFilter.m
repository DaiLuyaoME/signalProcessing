function [b,a] = secOrderFilter(f,fs)

w = f * 2  * pi;
G = tf(w*w,[1,2*0.7*w,w*w]);
GDis = c2d(G,1/fs,'tustin');
[b,a] = tfdata(GDis,'v');

end
