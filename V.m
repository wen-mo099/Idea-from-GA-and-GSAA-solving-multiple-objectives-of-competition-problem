function [v] = V(x)
%V(x) is the unique solution v in (0,1)
func=@(t)t*exp(t/(1-t))-x;
v=fzero(func,0.5)
end