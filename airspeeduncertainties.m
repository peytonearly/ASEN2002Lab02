%Airspeed uncertainties
R = 8.314;%[J/mol.K]
delT = 1/4;%[deg C]
delp = 0.01;
delPatm = 3.75;%[1.5% of 250]

dvdp = ((R*Tatm)/(Patm*(1-((A2/A1)^2))))*sqrt((Patm*(1-((A2/A1)^2)))/(2*p*R*Tatm));
dvdTatm = ((p*R)/(Patm(1-((A2/A1)^2))))*sqrt((Patm*(1-((A2/A1)^2)))/(2*p*R*Tatm));
dvdPatm = (sqrt((Patm*(1-((A2/A1)^2)))/(2*p*R*Tatm)))*((p*R*Tatm)/(1-((A2/A1)^2)))*(-(Patm^2));
dv = sqrt(((dvdp*delp)^2)+((dvdTatm*delT)^2)+((dvdPatm*delPatm)^2));

