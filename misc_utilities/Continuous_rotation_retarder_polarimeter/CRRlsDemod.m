function M = CRRlsDemod(f0,f1,p0,p1,d0,d1,I,t,Mr,Mt)
% Equation 10.
% Numerical least-squares demodulation
Mat = kron(inv(Mt),transpose(inv(Mr)));

B = zeros(length(t),16);
arg0 = 2*(2*pi*f0.*t + p0);
arg1 = 2*(2*pi*f1.*t + p1);
Cp0 = cos(arg0);
Sp0 = sin(arg0);
Cp1 = cos(arg1);
Sp1 = sin(arg1);
Cd0 = cos(d0);
Sd0 = sin(d0);
Cd1 = cos(d1);
Sd1 = sin(d1);
B(:,1) = ones(1,length(t));
B(:,2) = Cp0.^2 + Cd0.*Sp0.^2;
B(:,3) = Cp0.*Sp0.*(1 - Cd0);
B(:,4) = Sd0.*Sp0;
B(:,5) = -(Cp1.^2 + Cd1.*Sp1.^2);
B(:,9) = -Cp1.*Sp1.*(1 - Cd1);
B(:,13) = Sd1.*Sp1;
B(:,6) = B(:,2).*B(:,5);
B(:,7) = B(:,3).*B(:,5);
B(:,8) = B(:,4).*B(:,5);
B(:,10) = B(:,2).*B(:,9);
B(:,11) = B(:,3).*B(:,9);
B(:,12) = B(:,4).*B(:,9);
B(:,14) = B(:,2).*B(:,13);
B(:,15) = B(:,3).*B(:,13);
B(:,16) = B(:,4).*B(:,13);
%A = pinv(B)*I';  %pinv(B) is the Moore-Penrose pseudoinverse of B
A = pinv(B);
M = A*I';
M = Mat*M;
M = reshape(M,4,4)';
end