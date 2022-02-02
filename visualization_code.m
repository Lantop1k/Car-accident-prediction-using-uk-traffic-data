
clc
clear all
close all


%read data
rng(0)
[~,~,raw]=xlsread('accident_information.xlsx');
data=raw(2:end,:);

%extract attributes from accident information
st_Road_Class = categorical(data(:,2)); %first Road Class
carriagehazard = categorical(data(:,7)); %carriage Hazard
accident_severity = categorical(data(:,6)); %accident severity
day_of_the_week = categorical(data(:,9));   %day of the week
junction_Control = categorical(data(:,11));  %junction control
junction_Detail = categorical(data(:,12));  %junction detail
Road_Surface_Conditions = categorical(data(:,26)); %Road surface conditions
Road_Type = categorical(data(:,27));    %Road type
Light_Condition = categorical(data(:,14)); %Light condition
Weather_Conditions = categorical(data(:,32)); %weather condition
nd_Road_Class = categorical(data(:,4));  %second road class
Urban_or_Rural_Area = categorical(data(:,31)); %urban or rural area
lat = cell2mat(data(1:10000,13));   %latitude
lon = cell2mat(data(1:10000,19)); %longtitude
Number_of_Casualties = data(:,21);  %Number of casualties
Number_of_Vehicles = data(:,22);   %Number of vehicles
Pedestrian_Crossing_Physical_Facilities = data(:,24); %pedestrian crossing physical facilities

%plot each attributes 
figure(1)
histogram(st_Road_Class)  %plot the histogram
title('First Road Class')

%plot each carriage hazard
figure(2)
histogram(carriagehazard)
title('Accident Carriage Hazard')

%plot the day of the week
figure(3)
histogram(day_of_the_week)
title('Day of the week')

%plot the accident severity
figure(4)
histogram(accident_severity)
title('Accident Severity Attribute')

%plot the junction detail
figure(5)
histogram(junction_Detail)
title('Junction Detail')

%plot road surface conditions
figure(6)
histogram(Road_Surface_Conditions)
title('Road Surface Conditions')

%plot Road type
figure(7)
histogram(Road_Type)
title('Road Type')

%plot light condition
figure(8)
histogram(Light_Condition)
title('Light Condition')

%plot weather conditions
figure(9)
histogram(Weather_Conditions)
title('Weather Conditions')

%plot second Road class
figure(10)
histogram(nd_Road_Class)
title('2nd Road Class')

%plot the urban or Rural area
figure(11)
histogram(Urban_or_Rural_Area)
title('Urban or Rural Area')

%plot the latitude and longittude 
figure(12)
worldmap([min(lat) max(lat)],[min(lon) max(lon)])
geoshow(lat,lon,'DisplayType','MultiPoint')
demcmap(lat)

%plot the number of casualities
figure(13)
histogram(cell2mat(Number_of_Casualties))
title('Number of Casualties')

%plot the number of vehicles
figure(14)
histogram(cell2mat(Number_of_Vehicles))
title('Number of Vehicles')

%plot the pedestrain crossing physical facilities
figure(15)
histogram(cell2mat(Pedestrian_Crossing_Physical_Facilities(1:20000)))
title('Pedestrian Crossing Physical Facilities')


%Balancing the dataset , obtain indexes of each values in accident severity
idxSerious = find(accident_severity=='Serious');
idxSlight = find(accident_severity=='Slight');
idxFatal = find(accident_severity=='Fatal');

%obtain the minimum size
nsize = min([length(idxSerious),length(idxSlight),length(idxFatal)]);

%set the miinimum 
idxS = datasample(idxSerious,nsize);
idxSl = datasample(idxSlight,nsize);
idxF = datasample(idxFatal,nsize);

%obtain the serious, slight, fatal
Serious = accident_severity(idxS);
Slight = accident_severity(idxSl);
Fatal = accident_severity(idxF);

%get the accident severity
accident_sev = vertcat(Serious,Slight,Fatal);

%plot the balanced of the accident severity
figure(16)
histogram(accident_sev)
title('Accident Severity')

%extract the indexes
idx = vertcat(idxS,idxSl,idxF);


datab = data(idx,:);


%extract vehicle information dataset
[~,~,raw] = xlsread('Vehicle_Information.xlsx');
data = raw(2:end,:);

Age_Band_of_Driver = categorical(data(:,2)); %extract the age band of driver
%Age_of_Vehicle= data(:,3);          %extract the age of vehicle
Sex_of_Driver = categorical(data(:,14));     %extract the sex of driver

%plot the age band of driver
figure(16)
histogram(Age_Band_of_Driver)
title('Age-Band of Driver')

%plot the sex of driver
figure(17)
histogram(Sex_of_Driver)
title('Sex of Driver')


datab2 = data(idx,:);
datab = horzcat(datab,datab2(:,2),datab2(:,3),datab2(:,14));
datab(strcmp(datab(:,2),'Unclassified') == 1,:)=[];
datab(strcmp(datab(:,4),'Unclassified') == 1,:)=[];
datab(strcmp(datab(:,11),'Data missing') == 1,:)=[];
datab(strcmp(datab(:,27),'Unknown')==1,:) = [];
datab(strcmp(datab(:,12),'Data missing or out of range') == 1,:) = [];
datab(strcmp(datab(:,14),'Darkness-lighting unknown')==1,:) = [];
datab(strcmp(datab(:,31),'Unallocated')==1,:) = [];

datab(strcmp(datab(:,35),'Data missing or out of range') == 1,:) = [];
datab(strcmp(datab(:,36),'NA')==1,:) = [];
datab(strcmp(datab(:,37),'Not known') == 1,:) = [];

%remove some class in the dataset
input=horzcat(datab(:,2),datab(:,4),datab(:,9),datab(:,11),datab(:,12),...
    datab(:,14), datab(:,13),datab(:,19),datab(:,21),datab(:,24),datab(:,26),datab(:,27),datab(:,29),...
    datab(:,31),datab(:,32),datab(:,35),datab(:,36),datab(:,37));

target=categorical(datab(:,6)); %target

%save input and target
save('input','input');
save('target','target');