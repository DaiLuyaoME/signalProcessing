function [loc,value] = findNotch(data,maxHeight)

temp = diff( sign(diff(data)) );
loc = find( temp == 2);
loc = loc + 1;
loc = loc( data(loc) < maxHeight);
value = data(loc);

end
