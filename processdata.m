function [input,target]=processdata(file)



[num,raw,~]=xlsread(file);

%export variables
Accident_Index=raw(:,1);
Location_Easting_OSGR=num(:,2);
Location_Northing_OSGR=num(:,3);
Longitude=num(:,4);
Latitude=num(:,5);
Police_Force=num(:,6);
Accident_Severity=num(:,7);
Number_of_Vehicles=num(:,8);
Number_of_Casualties=num(:,9);
Date=raw(:,10);
Day_of_Week=num(:,11);
Time=raw(:,12);
Local_Authority_District=num(:,13);
Local_Authority_Highway=raw(:,14);
st_Road_Class=num(:,15);
st_Road_Number=num(:,16);
Road_Type=num(:,17);
Speed_limit=num(:,18);
Junction_Detail=num(:,19);
Junction_Control=num(:,20);
nd_Road_Class=num(:,21);
nd_Road_Number=num(:,22);
Pedestrian_Crossing_Human_Control=num(:,22);
Pedestrian_Crossing_Physical_Facilities=num(:,23);
Light_Conditions=num(:,24);
Weather_Conditions=num(:,25);
Road_Surface_Conditions=num(:,26);
Special_Conditions_at_Site=num(:,27);
Carriageway_Hazards=num(:,28);
Urban_or_Rural_Area=num(:,29);
Did_Police_Officer_Attend_Scene_of_Accident=raw(:,30);


Data=horzcat(Location_Easting_OSGR,Location_Northing_OSGR,Longitude,Latitude,Accident_Severity,...
            Day_of_Week,st_Road_Class,Road_Type,...
            Speed_limit,Junction_Detail,Junction_Control,nd_Road_Class,...
            Pedestrian_Crossing_Human_Control,Pedestrian_Crossing_Physical_Facilities,Light_Conditions,...
            Weather_Conditions,Road_Surface_Conditions,Urban_or_Rural_Area);
        
Data = standardizeMissing(Data,-1);
Data=rmmissing(Data);


input=Data;       
input(:,5)=[];
target=Data(:,5);

end