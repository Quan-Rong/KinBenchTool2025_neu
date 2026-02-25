
if isempty(app.EditField_browser_R_braking.Value)
    uialert(app.UIFigure, 'please select a file!', 'Error');
    return;
end
%clc,clear;

% 定位res文件，定位文件路径和文件名
steps=0;
filedir = app.EditField_browser_R_braking.Value;
[~,filename,ext]=fileparts(filedir);

filename2=filename;


%计时器
%timerVal=tic;

% 判断计算机操作系统
if (isunix) % Linux系统提供了wc命令可以直接使用
    % 使用syetem函数可以执行操作系统的函数
    % 比如window中dir，linux中ls等
    [~, numstr] = system( ['wc -l ', filedir] );
    row=str2double(numstr);
elseif (ispc) % Windows系统可以使用perl命令
    % perl文件内容很简单就两行
    % while (<>) {};
    % print $.,"\n";
    fid=fopen('countlines.pl','w');
    fprintf(fid,'%s\n%s','while (<>) {};','print $.,"\n";');
    fclose(fid);

    % 执行perl脚本
    row=str2double( perl('countlines.pl', filedir) );
end

fidin=fopen(filedir);

% 预设指针及其它参数
RowNo=0;
% Extract ONLY the numeric value inside `id="..."` from XML `<Component .../>` lines.
% IDs are file-dependent and can differ between *.res results.
expression = '(?<=id=")\d+(?=")';
Flag=1;
No_Row=0; % 记录当前文件行数

%res文件循环遍历文件尾寻找各K&C参数对应的ID号并转换为double存入1*2 array, 1,1->links und 1,2->rechts
%得到的ID分配如下：
%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%                                                        |                                                       |                                                                                         %
% toe_angle                = left:1796   /   right:1797  | roll_center_location   = later:1776   / vertical:1777 | wheel_travel           = later:1621    / vertical:1622                                  %
% camber_angle             = left:1798   /   right:1799  | anti_dive              = left:1734    /    right:1735 | roll_angle             = WC:1629       /       CP:1630                                  %
% caster_angle             = left:1760   /   right:1761  | anti_lift              = left:1742    /    right:1743 | wheel_load_lateral     = left:1635     /    right:1636                                  %
% kingpin_incl_angle       = left:1762   /   right:1763  | roll_Steer             = left:1774    /    right:1775 | wheel_load_longitudinal= brak_left:1631/brak_right:1632/driv_left:1633/driv_right:1634  %
% caster_moment_arm        = left:1790   /   right:1791  | roll_camber_coefficient= left:1770    /    right:1771 | wheel_load_align       = left:1641     /    right:1642                                  %
% scrub_radius             = left:1788   /   right:1789  | susp_roll_rate         = vehicle:1784                 | ideal_steer_angle      = left:1810     /    right:1811                                  %
% left_tire_contact_point  = base:1825   /   track:1826  | total_roll_rate        = vehicle:1785                 | steer_angle            = left:1802     /    right:1803                                  %
% right_tire_contact_point = base:1830   /   track:1831  | wheel_rate             = left:1780    /    right:1781 | steering_displacements =                                                                %
% wheel_travel_track       = left:1627   /   right:1628  | ride_rate              = left:1782    /    right:1783 | steering_wheel_input   =                                                                %
% wheel_travel_base        = left:1625   /   right:1626  | left_tire_forces       = x:1867  /  y:1868  /  z:1869 | steering_rack_input    =                                                                %
% total_track              = vehicle:1824                | right_tire_forces      = x:1879  /  y:1880  /  z:1881 | percent_ackerman       = left:1808     /    right:1809                                  %
%                                                        |                                                       | outside_turn_diameter  = left:1814     /    right:1815                                  %
%                                                        |                                                       |                                                                                         %
% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
while ~feof(fidin)
    No_Row=No_Row+1;
    tline=fgetl(fidin);
    if contains(tline,'toe_angle')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        toe_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        toe_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'camber_angle')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        camber_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        camber_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'"caster_angle"')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        caster_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        caster_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'"kingpin_incl_angle"')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        kingpin_incl_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        kingpin_incl_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'caster_moment_arm')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        caster_moment_arm_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        caster_moment_arm_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'scrub_radius')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        scrub_radius_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        scrub_radius_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'left_tire_contact_point')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        left_tire_contact_point_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        left_tire_contact_point_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'right_tire_contact_point')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        right_tire_contact_point_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        right_tire_contact_point_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'"wheel_travel_track"')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        wheel_travel_track_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        wheel_travel_track_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'wheel_travel_base')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        wheel_travel_base_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        wheel_travel_base_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'total_track')
        No_Row=No_Row+1;
        tline1=fgetl(fidin);
        total_track_ID=str2double(char(regexpi(tline1,expression,'match')));
    end
    if contains(tline,'roll_center_location')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        roll_center_location_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        roll_center_location_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'anti_dive')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        anti_dive_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        anti_dive_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'anti_lift')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        anti_lift_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        anti_lift_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'roll_steer')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        roll_steer_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        roll_steer_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'roll_camber_coefficient')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        roll_camber_coefficient_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        roll_camber_coefficient_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'susp_roll_rate')
        No_Row=No_Row+1;
        tline1=fgetl(fidin);
        susp_roll_rate_ID=str2double(char(regexpi(tline1,expression,'match')));
    end
    if contains(tline,'total_roll_rate')
        No_Row=No_Row+1;
        tline1=fgetl(fidin);
        total_roll_rate_ID=str2double(char(regexpi(tline1,expression,'match')));
    end
    if contains(tline,'wheel_rate')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        wheel_rate_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        wheel_rate_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'ride_rate')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        ride_rate_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        ride_rate_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'left_tire_forces')
        No_Row=No_Row+3;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        tline3=fgetl(fidin);
        left_tire_forces_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        left_tire_forces_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
        left_tire_forces_ID(3)=str2double(char(regexpi(tline3,expression,'match')));
    end
    if contains(tline,'right_tire_forces')
        No_Row=No_Row+3;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        tline3=fgetl(fidin);
        right_tire_forces_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        right_tire_forces_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
        right_tire_forces_ID(3)=str2double(char(regexpi(tline3,expression,'match')));
    end
    if contains(tline,'"wheel_travel"')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        wheel_travel_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        wheel_travel_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'"roll_angle"')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        roll_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        roll_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'wheel_load_lateral')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        wheel_load_lateral_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        wheel_load_lateral_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'wheel_load_longitudinal')
        No_Row=No_Row+4;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        tline3=fgetl(fidin);
        tline4=fgetl(fidin);
        wheel_load_longitudinal_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        wheel_load_longitudinal_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
        wheel_load_longitudinal_ID(3)=str2double(char(regexpi(tline3,expression,'match')));
        wheel_load_longitudinal_ID(4)=str2double(char(regexpi(tline4,expression,'match')));
    end
    if contains(tline,'wheel_load_align')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        wheel_load_align_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        wheel_load_align_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    %                 if contains(tline,'ideal_steer_angle')
    %                     No_Row=No_Row+2;
    %                     tline1=fgetl(fidin);
    %                     tline2=fgetl(fidin);
    %                     ideal_steer_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
    %                     ideal_steer_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    %                 end
    %                 if contains(tline,'steer_angle')
    %                     No_Row=No_Row+2;
    %                     tline1=fgetl(fidin);
    %                     tline2=fgetl(fidin);
    %                     steer_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
    %                     steer_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    %                 end
    if contains(tline,'side_view_swing_arm_angle')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        side_view_swing_arm_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        side_view_swing_arm_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'side_view_swing_arm_length')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        side_view_swing_arm_length_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        side_view_swing_arm_length_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'steering_displacements')
        No_Row=No_Row+1;
        tline1=fgetl(fidin);
        steering_displacements_ID=str2double(char(regexpi(tline1,expression,'match')));
    end
    if contains(tline,'steering_wheel_input')
        No_Row=No_Row+1;
        steering_wheel_input_ID=str2double(char(regexpi(tline,expression,'match')));
        Flag=1;
    end
    % if contains(tline,'steering_rack_input')
    %     No_Row=No_Row+1;
    %     tline1=fgetl(fidin);
    %     steering_rack_input_ID=str2double(char(regexpi(tline1,expression,'match')));
    %     Flag=0;
    % end
    if contains(tline,'"anti_squat_acceleration"')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        anti_squat_acceleration_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        anti_squat_acceleration_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'percent_ackerman')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        percent_ackerman_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        percent_ackerman_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'outside_turn_diameter')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        outside_turn_diameter_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        outside_turn_diameter_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'"wheel_load_vertical_force"')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        wheel_load_vertical_force_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        wheel_load_vertical_force_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    %得到的ID分配如下：
    %----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
    %                                                        |                                                       |                                                                                         %
    % toe_angle                = left:1796   /   right:1797  | roll_center_location   = later:1776   / vertical:1777 | wheel_travel           = left:1621    / vright:1622                                  %
    % camber_angle             = left:1798   /   right:1799  | anti_dive              = left:1734    /    right:1735 | roll_angle             = WC:1629       /       CP:1630                                  %
    % caster_angle             = left:1760   /   right:1761  | anti_lift              = left:1742    /    right:1743 | wheel_load_lateral     = left:1635     /    right:1636                                  %
    % kingpin_incl_angle       = left:1762   /   right:1763  | roll_Steer             = left:1774    /    right:1775 | wheel_load_longitudinal= brak_left:1631/brak_right:1632/driv_left:1633/driv_right:1634  %
    % caster_moment_arm        = left:1790   /   right:1791  | roll_camber_coefficient= left:1770    /    right:1771 | wheel_load_align       = left:1641     /    right:1642                                  %
    % scrub_radius             = left:1788   /   right:1789  | susp_roll_rate         = vehicle:1784                 | ideal_steer_angle      = left:1810     /    right:1811                                  %
    % left_tire_contact_point  = base:1825   /   track:1826  | total_roll_rate        = vehicle:1785                 | steer_angle            = left:1802     /    right:1803                                  %
    % right_tire_contact_point = base:1830   /   track:1831  | wheel_rate             = left:1780    /    right:1781 | steering_displacements =                                                                %
    % wheel_travel_track       = left:1627   /   right:1628  | ride_rate              = left:1782    /    right:1783 | steering_wheel_input   =                                                                %
    % wheel_travel_base        = left:1625   /   right:1626  | left_tire_forces       = x:1867  /  y:1868  /  z:1869 | steering_rack_input    =                                                                %
    % total_track              = vehicle:1824                | right_tire_forces      = x:1879  /  y:1880  /  z:1881 | percent_ackerman       = left:1808     /    right:1809                                  %
    % wheel_load_vertical_force= left:1637   /   right:1638  |                                                       | outside_turn_diameter  = left:1814     /    right:1815                                  %
    %                                                        | side_view_swing_arm_angle= left:1792    /    right:1793                                                     |
    %                                                          side_view_swing_arm_length= left:1794    /    right:1795
    % ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
    %将res文件中的2751个各参数结果存入矩阵quasiStatic_data中，quasiStatic_data1用来存储分析步标识/Step。所以有n个分析步，则quasiStatic_data有n+行，2751列。
    %将来需要什么数据，则根据参数对应的ID号读取quasiStatic_data(;,ID)的内容即可
    while contains(tline,'"quasiStatic"') % 判断静态分析开始的标志
        RowNo=RowNo+1;
        Test_Data=[];
        while ~feof(fidin)
            No_Row=No_Row+1;
            tline=fgetl(fidin);
            if  ~isempty(str2num(tline)) %判断字符串数组首个元素是不是数字
                Test_Data=[Test_Data str2num(tline)];
            else
                break;
            end
        end
        quasiStatic_data(RowNo,:)=Test_Data(1,:);
    end
    %waitbar(No_Row/row);
end

if contains(filename2,'static_load')
    Susp_static_load_ID=[toe_angle_ID,camber_angle_ID,wheel_travel_base_ID,wheel_travel_track_ID,left_tire_contact_point_ID(1),right_tire_contact_point_ID(1),...
        left_tire_contact_point_ID(2),right_tire_contact_point_ID(2),wheel_load_lateral_ID,wheel_load_longitudinal_ID,wheel_load_align_ID,...
        wheel_load_vertical_force_ID(1),wheel_load_vertical_force_ID(2),caster_angle_ID(1),caster_angle_ID(2),kingpin_incl_angle_ID(1),kingpin_incl_angle_ID(2),...
        scrub_radius_ID(1),scrub_radius_ID(2),caster_moment_arm_ID(1),caster_moment_arm_ID(2), left_tire_forces_ID(3), right_tire_forces_ID(3),anti_squat_acceleration_ID(1),anti_squat_acceleration_ID(2)];
    Susp_static_load_data=quasiStatic_data(:,Susp_static_load_ID);
    Susp_static_load_data(:,1:4)=Susp_static_load_data(:,1:4)*180/pi;
    Susp_static_load_data(:,23:26)=Susp_static_load_data(:,23:26)*180/pi;


    if abs(Susp_static_load_data(1,13))>=1500  %用来wheel load lat 的值是否大于1500判定是不是侧向力工况
        [Row_Data_p0,Row_No_p0]=min(abs(Susp_static_load_data(:,13)));             % 定位拟合区间的 0 N 第51行
        if (Susp_static_load_data(end,13)-Susp_static_load_data(1,13))>0
            [Row_Data_p1,Row_No_p1]=min(abs(Susp_static_load_data(:,13)+app.EditField_R_lat_rangeshow.Value)); % 定位拟合区间的min -480N 第45行
            [Row_Data_p2,Row_No_p2]=min(abs(Susp_static_load_data(:,13)-app.EditField_R_lat_rangeshow.Value)); % 定位拟合区间的max  480N 第57行
        else
            [Row_Data_p1,Row_No_p1]=min(abs(Susp_static_load_data(:,13)-app.EditField_R_lat_rangeshow.Value));
            [Row_Data_p2,Row_No_p2]=min(abs(Susp_static_load_data(:,13)+app.EditField_R_lat_rangeshow.Value));
        end
        if (Row_No_p0-Row_No_p1)>(Row_No_p2-Row_No_p0)
            Row_No_p1=Row_No_p1+1;
        end

        Lat_toe_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,13),Susp_static_load_data(Row_No_p1:Row_No_p2,1),1);
        %侧向力正负500N区间内对左toe进行线性拟合
        Lat_camber_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,13),Susp_static_load_data(Row_No_p1:Row_No_p2,3),1);
        %侧向力正负500N区间内对左camber进行线性拟合
        Lat_WC_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,13),Susp_static_load_data(Row_No_p1:Row_No_p2,7),1);
        %侧向力正负500N区间内对左wheel travel track进行线性拟合
        Lat_PC_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,13),Susp_static_load_data(Row_No_p1:Row_No_p2,11),1);
        %侧向力正负500N区间内对左tire cp 的y变化量进行线性拟合

        Lat_toe_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,14),Susp_static_load_data(Row_No_p1:Row_No_p2,2),1);
        Lat_camber_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,14),Susp_static_load_data(Row_No_p1:Row_No_p2,4),1);
        Lat_WC_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,14),Susp_static_load_data(Row_No_p1:Row_No_p2,8),1);
        Lat_PC_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,14),Susp_static_load_data(Row_No_p1:Row_No_p2,12),1);




        % Braking Forece Test Plot//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    elseif abs(Susp_static_load_data(1,15))>=1500  %用来wheel load braking 的值是否大于1500判定是不是纵向力工况
        [Row_Data_p0,Row_No_p0]=min(abs(Susp_static_load_data(:,15)));             % 定位拟合区间的 0 N 第51行
        if (Susp_static_load_data(end,15)-Susp_static_load_data(1,15))>0
            [Row_Data_p1,Row_No_p1]=min(abs(Susp_static_load_data(:,15)+app.EditField_R_braking_rangeshow.Value)); % 定位拟合区间的min -480N 第45行
            [Row_Data_p2,Row_No_p2]=min(abs(Susp_static_load_data(:,15)-app.EditField_R_braking_rangeshow.Value)); % 定位拟合区间的max  480N 第57行
        else
            [Row_Data_p1,Row_No_p1]=min(abs(Susp_static_load_data(:,15)-app.EditField_R_braking_rangeshow.Value));
            [Row_Data_p2,Row_No_p2]=min(abs(Susp_static_load_data(:,15)+app.EditField_R_braking_rangeshow.Value));
        end
        if (Row_No_p0-Row_No_p1)>(Row_No_p2-Row_No_p0)
            Row_No_p1=Row_No_p1+1;
        end

        braking_toe_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,15),Susp_static_load_data(Row_No_p1:Row_No_p2,1),1);
        %侧向力正负500N区间内对左toe进行线性拟合
        braking_camber_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,15),Susp_static_load_data(Row_No_p1:Row_No_p2,3),1);
        %侧向力正负500N区间内对左camber进行线性拟合
        braking_WC_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,15),Susp_static_load_data(Row_No_p1:Row_No_p2,5),1);
        %侧向力正负500N区间内对左wheel travel track进行线性拟合
        braking_PC_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,15),Susp_static_load_data(Row_No_p1:Row_No_p2,9),1);
        %侧向力正负500N区间内对左tire cp 的y变化量进行线性拟合
        braking_antidive_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,15),Susp_static_load_data(Row_No_p1:Row_No_p2,31),1);

        braking_toe_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,16),Susp_static_load_data(Row_No_p1:Row_No_p2,2),1);
        braking_camber_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,16),Susp_static_load_data(Row_No_p1:Row_No_p2,4),1);
        braking_WC_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,16),Susp_static_load_data(Row_No_p1:Row_No_p2,6),1);
        braking_PC_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,16),Susp_static_load_data(Row_No_p1:Row_No_p2,10),1);
        braking_antidive_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,16),Susp_static_load_data(Row_No_p1:Row_No_p2,32),1);


        %------------------------------------------------------------------------------------------------------------------------
        % braking toe change
        %------------------------------------------------------------------------------------------------------------------------

        app.brakingtoeEditField.Value =1000*(round(braking_toe_cf_left(1,1),6)+round(braking_toe_cf_right(1,1),6))/2;
        %left---------------------------------------------------
        subplot(1, 2, 1);

        plot(Susp_static_load_data(:,15),Susp_static_load_data(:,1),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(Susp_static_load_data(Row_No_p1:Row_No_p2,15),braking_toe_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,15)+braking_toe_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_braking_rangeshow.Value) 'N, ' num2str(app.EditField_R_braking_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel('toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel('longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        YAxis.FontSize=10;
        XAxis.FontSize=10;

        title('Braking Toe Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box('on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakingtoe); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(x_ticks);

        %set('XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingtoe_left = legend('show');
        set(legend_R_brakingtoe_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(braking_toe_cf_left(1,1),6))  '*x+' num2str(round(braking_toe_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman');

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold');
        text(0.03, 0.5,'toe out                                      toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90);


        %right---------------------------------------------------
        subplot(1, 2, 2);

        plot(Susp_static_load_data(:,16),Susp_static_load_data(:,2),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(Susp_static_load_data(Row_No_p1:Row_No_p2,16),braking_toe_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,16)+braking_toe_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_braking_rangeshow.Value) 'N, ' num2str(app.EditField_R_braking_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel('toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel('longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        YAxis.FontSize=10;
        XAxis.FontSize=10;

        title('Braking Toe Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box('on');

        xticks( x_ticks);

        set('XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend('show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(braking_toe_cf_right(1,1),6))  '*x+' num2str(round(braking_toe_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman');

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold');
        text(0.03, 0.5,'toe out                                      toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90);

        sgtitle('总标题');


    elseif abs(Susp_static_load_data(1,17))>=1500  %用来wheel load accel 的值是否大于1500判定是不是侧向力工况
        [Row_Data_p0,Row_No_p0]=min(abs(Susp_static_load_data(:,17)));             % 定位拟合区间的 0 N 第51行
        if (Susp_static_load_data(end,15)-Susp_static_load_data(1,17))>0
            [Row_Data_p1,Row_No_p1]=min(abs(Susp_static_load_data(:,17)+app.EditField_R_accel_rangeshow.Value)); % 定位拟合区间的min -480N 第45行
            [Row_Data_p2,Row_No_p2]=min(abs(Susp_static_load_data(:,17)-app.EditField_R_accel_rangeshow.Value)); % 定位拟合区间的max  480N 第57行
        else
            [Row_Data_p1,Row_No_p1]=min(abs(Susp_static_load_data(:,17)-app.EditField_R_accel_rangeshow.Value));
            [Row_Data_p2,Row_No_p2]=min(abs(Susp_static_load_data(:,17)+app.EditField_R_accel_rangeshow.Value));
        end
        if (Row_No_p0-Row_No_p1)>(Row_No_p2-Row_No_p0)
            Row_No_p1=Row_No_p1+1;
        end

        accel_toe_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,17),Susp_static_load_data(Row_No_p1:Row_No_p2,1),1);
        %侧向力正负500N区间内对左toe进行线性拟合
        accel_camber_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,17),Susp_static_load_data(Row_No_p1:Row_No_p2,3),1);
        %侧向力正负500N区间内对左camber进行线性拟合
        accel_WC_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,17),Susp_static_load_data(Row_No_p1:Row_No_p2,5),1);
        %侧向力正负500N区间内对左wheel travel track进行线性拟合

        accel_antidive_cf_left=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,17),Susp_static_load_data(Row_No_p1:Row_No_p2,33),1);

        accel_toe_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,18),Susp_static_load_data(Row_No_p1:Row_No_p2,2),1);
        accel_camber_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,18),Susp_static_load_data(Row_No_p1:Row_No_p2,4),1);
        accel_WC_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,18),Susp_static_load_data(Row_No_p1:Row_No_p2,6),1);

        accel_antidive_cf_right=polyfit(Susp_static_load_data(Row_No_p1:Row_No_p2,18),Susp_static_load_data(Row_No_p1:Row_No_p2,34),1);


    end
end

