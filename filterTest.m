dataFilter1 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .1, 'PassbandRipple', 0.01);
dataFilter2 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .05, 'PassbandRipple', 0.01);
dataFilter3 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .01, 'PassbandRipple', 0.01);
dataFilter4 = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', .005, 'PassbandRipple', 0.01);
fvtool(dataFilter1,dataFilter2,dataFilter3,dataFilter4);