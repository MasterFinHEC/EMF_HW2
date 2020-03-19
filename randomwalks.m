%% Random Walks

function [p_t]=randomwalks(N,T)

%Computing N time-series with T stock prices following a random walk

p_t=zeros(T,N);
eps_t=normrnd(0,1,[T,1]);
for n=1:N
    p=zeros(T,1);
    for t=2:T
        A=sign(randn);
        p(t)=A+eps_t(t);
    end
    p_t(:,n)=p;
end
