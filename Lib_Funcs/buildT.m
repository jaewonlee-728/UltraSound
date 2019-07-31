function [ T ] = buildT( v )
%BUILDT Summary of this function goes here
%   Detailed explanation goes here

T = [cos(v(1))*cos(v(2)) cos(v(1))*sin(v(2))*sin(v(3))-sin(v(1))*cos(v(3)) cos(v(1))*sin(v(2))*cos(v(3))+sin(v(1))*sin(v(3)) v(4);
    sin(v(1))*cos(v(2)) sin(v(1))*sin(v(2))*sin(v(3))+cos(v(1))*cos(v(3)) sin(v(1))*sin(v(2))*cos(v(3))-cos(v(1))*sin(v(3)) v(5);
    -sin(v(2)) cos(v(2))*sin(v(3)) cos(v(2))*cos(v(3)) v(6);
    0 0 0 1];

end

