function [loc,value] = findPeak(data,minHeight)

temp = diff( sign(diff(data)) );
loc = find( temp == -2);
loc = loc + 1;
loc = loc( data(loc) > minHeight);
value = data(loc);

end
% findpeaks
