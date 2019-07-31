function [ ErrCount, ErrRate ] = Error_Counting( Threashhold, Result )
%ERROR_COUNTING Summary of this function goes here
%   Detailed explanation goes here
ErrCount = 0;
for t=1:size(Result,1)
if t<Threashhold+1
if Result(t,1)~=-1
    ErrCount = ErrCount +1;
end
end

if t>Threashhold
if Result(t,1)~=1
    ErrCount = ErrCount +1;
end
end
end

ErrRate = ErrCount/size(Result,1);

end

