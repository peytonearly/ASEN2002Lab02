%%
%House Cleaning
clear all
clc
close
load('AirfoilData.mat')
%% Question (3) 
top_x = [2.1 2.8];
bottom_x = [2.8 2.1];

for i = 1:height(AirfoilData)
    q = AirfoilData{i,5};
    
    P8 = AirfoilData{i,14};
    P10 = AirfoilData{i,16};
    CP8(i) = P8/q;  %scanivale8/pitotpressure
    CP10(i) = P10/q;
    
    P12 = AirfoilData{i,18};
    P14 = AirfoilData{i,20};
    CP12(i) = P12/q;  %scanivale8/pitotpressure
    CP14(i) = P14/q;
    
    CP_top = [CP8(i) CP10(i)];
    CP_bottom = [CP12(i) CP14(i)];
    
    P_top = polyfit(top_x,CP_top,1);
    P_bottom = polyfit(bottom_x,CP_bottom,1);
    
    x1 = polyval(P_top,3.5);
    x2 = polyval(P_bottom,3.5);
    
    CP11(i) = (x1+x2)/2;
    P11(i) = CP11(i) * q;
end

%% Question (4)
for i = 1:height(AirfoilData)
    for j = 1:16
        q = AirfoilData{i,5};
        P = AirfoilData{i,j+6}; 
        CP(j,i) = P./q; 
    end
end
%rows 1-16 are ports 1-16
%every 3 columns the aoa changes
    %the 3 columns per aoa are for the 3 different airspeeds

%% Question (5)
x_length = [0,.175,.35,.7,1.05,1.4,1.75,2.1,2.45,2.8,3.5,2.8,2.45,2.1,1.75,1.4,0];
NCL = x_length./3.5;
%creating artifical values to close loop on plot
y_9(17) = 0;
y_16(17) = 0;
y_33(17) = 0;
%for aoa -9
for i = 1:16
    y_9(i) = CP(i,19);
    y_16(i) = CP(i,20);
    y_33(i) = CP(i,21);
end


figure(1)
hold on
plot(NCL, flip(y_9))
plot(NCL,flip(y_16))
plot(NCL,flip(y_33))
xlabel('Unit length [in]')
ylabel('Coefficent of Pressure')
title('Angle of Attack = - 9')
legend('V = 9 m/s','V = 16 m/s ', 'V = 33 m/s')
hold off
%for aoa 0
for i = 1:16
    y_9(i) = CP(i,46);
    y_16(i) = CP(i,47);
    y_33(i) = CP(i,49);
end

figure(2)
hold on
plot(NCL, flip(y_9))
plot(NCL,flip(y_16))
plot(NCL,flip(y_33))
xlabel('Unit length [in]')
ylabel('Coefficent of Pressure')
title('Angle of Attack = 0')
legend('V = 9 m/s','V = 16 m/s ', 'V = 33 m/s')
hold off

%for aoa 5
for i = 1:16
    y_9(i) = CP(i,61);
    y_16(i) = CP(i,62);
    y_33(i) = CP(i,63);
end

figure(3)
hold on
plot(NCL, flip(y_9))
plot(NCL,flip(y_16))
plot(NCL,flip(y_33))
xlabel('Unit length [in]')
ylabel('Coefficent of Pressure')
title('Angle of Attack = 5')
legend('V = 9 m/s','V = 16 m/s ', 'V = 33 m/s')
hold off
%for aoa 13
for i = 1:16
    y_9(i) = CP(i,85);
    y_16(i) = CP(i,86);
    y_33(i) = CP(i,87);
end

figure(4)
hold on
plot(NCL, flip(y_9))
plot(NCL,flip(y_16))
plot(NCL,flip(y_33))
xlabel('Unit length [in]')
ylabel('Coefficent of Pressure')
title('Angle of Attack = 13')
legend('V = 9 m/s','V = 16 m/s ', 'V = 33 m/s')
hold off

%for V = 16

y_neg9(17) = 0;
y_0(17) = 0;
y_5(17) = 0;
y_13(17) = 0;

for i = 1:16
    y_neg9(i) = CP(i,20);
    y_0(i) = CP(i,47);
    y_5(i) = CP(i,62);
    y_13(i) = CP(i,86);

end


figure(5)
hold on
plot(NCL,flip(y_neg9))
plot(NCL,flip(y_0))
plot(NCL,flip(y_5))
plot(NCL,flip(y_13))
xlabel('Unit length [in]')
ylabel('Coefficent of Pressure')
title('V = 16 m/s')
legend('AoA = - 9','AoA = 0 ', 'AoA = 5','AoA = 16')
hold off

%% Question (6)
y_length = [0.14465, 0.33075, 0.4018, 0.476, 0.49, 0.4774, 0.4403, 0.38325, 0.308, 0.21875, 0, 0, 0, 0, 0, 0, 0];

for i = 1:96
    temp = 0;
    temp2 = 0;
    for j = 1:15
        if j == 15
            Coeff = temp + ((-1/2)*(CP(j,i)+CP(16,i))*((x_length(16)-x_length(j))/3.5));    
            Coeff2 = temp2 + ((1/2)*(CP(j,i)+CP(16,i))*((y_length(16)-y_length(j))/3.5));
        else
            Coeff = temp + (-1*(CP(j,i)+CP(j+1,i))*((x_length(j+1)-x_length(j))/3.5));   
            Coeff2 = temp2 + ((1/2)*(CP(j,i)+CP(j+1,i))*((y_length(j+1)-y_length(j))/3.5));

        end       
        temp = Coeff;  
        temp2 = Coeff2;
    end
    Cn(i) = Coeff;
    Ca(i) = Coeff2;
end

aoa = -15;
for k = 1:96
    Clift(k) = (Cn(k)*cos(aoa)) - (Ca(k)*sin(aoa));
    Cdrag(k) = (Cn(k)*sin(aoa)) + (Ca(k)*cos(aoa));
    
    if mod(k,3) ~= 0
        aoa = aoa + 1;
    end
end

%% Question (7)

aoa = [-15:15];

temp = 1;
temp2 = 2;
temp3 = 3;
for i = 1:31
    %Coeff of Lift and Drag
    Cdrag_16(i) = Cdrag(temp2);
    Cdrag_33(i) = Cdrag(temp3);

    Clift_16(i) = Clift(temp2);
    Clift_33(i) = Clift(temp3);
    if i == 1
        Clift_9(i) = Clift(i);
        Cdrag_9(i) = Cdrag(i);
    else
        Clift_9(i) = Clift(temp);
        Cdrag_9(i) = Cdrag(temp);
    end

    temp = temp + 3;
    temp2 = temp2 + 3;
    temp3 = temp3 + 3;
end


figure(6)
hold on
plot(aoa,Clift_9)
plot(aoa,Clift_16)
plot(aoa,Clift_33)
xlabel('Angle of Attack')
ylabel('Coefficent of Lift')
title('Coeff of Lift vs Angle of Attack')
legend('V = 9 m/s','V = 16 m/s ', 'V = 33 m/s','Location','northwest')
hold off

figure(7)
hold on
plot(aoa,Cdrag_9)
plot(aoa,Cdrag_16)
plot(aoa,Cdrag_33)
xlabel('Angle of Attack')
ylabel('Coefficent of Drag')
title('Coeff of Drag vs Angle of Attack')
legend('V = 9 m/s','V = 16 m/s ', 'V = 33 m/s','Location','northwest')
hold off


