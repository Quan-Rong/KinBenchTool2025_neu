if isempty(app.EditField_browser_bump.Value)
    uialert(app.UIFigure, 'please select a file!', 'Error');
    return;
end

app.Image_kc_01_bump.Visible = "off";
app.Image_kc_02_bump.Visible = "off";

%clc,clear;

% 定位res文件，定位文件路径和文件名
steps=0;
filedir = app.EditField_browser_bump.Value;
[~,filename,ext]=fileparts(filedir);
filename1=[fileparts(filedir),'\',filename,'.xlsx'];
filename2=filename;

Input_HalfLoad = app.HalfLoadEditField.Value;
Input_MaxLoad = app.MaxLoadEditField.Value;
Input_Unsprung = app.UnsprungEditField.Value;
Input_WheelBase = app.WheelBaseEditField.Value;
Input_RollAngle = app.RollAngleEditField.Value

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
% NOTE:
% The column IDs used later (e.g. quasiStatic_data(:, ID)) are parsed from the
% XML `<Component ... id="..."/>` attributes in the current *.res file.
% These IDs are NOT universal constants; they can differ between result files.
% We therefore extract ONLY the number inside `id="..."`.
expression = '(?<=id=")\d+(?=")';
Flag=1;
No_Row=0; % 记录当前文件行数

%res文件循环遍历文件尾寻找各K&C参数对应的ID号并转换为double存入1*2 array, 1,1->links und 1,2->rechts
% 说明：不同 *.res 文件的 `<Component ... id="..."/>` 数值会变化（取决于文件里
% 定义了哪些 Entity/Component 以及顺序）。不要把旧工程里看到的 1796/1797 之类
% 数值当作固定常量；本脚本会从当前文件中自动解析。
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
    if contains(tline,'caster_angle')
        No_Row=No_Row+2;
        tline1=fgetl(fidin);
        tline2=fgetl(fidin);
        caster_angle_ID(1)=str2double(char(regexpi(tline1,expression,'match')));
        caster_angle_ID(2)=str2double(char(regexpi(tline2,expression,'match')));
    end
    if contains(tline,'kingpin_incl_angle')
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
    if contains(tline,'roll_angle')
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
    if contains(tline,'steering_rack_input')
        No_Row=No_Row+1;
        tline1=fgetl(fidin);
        steering_rack_input_ID=str2double(char(regexpi(tline1,expression,'match')));
        Flag=0;
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
%建立以filename为名字的excel结果输出文件
%dname=uigetdir(pathname);
%filename1=[dname,'\',char(regexp(filename,'\w*(?=.res)','match')),'.xlsx'];
%
%------------------------------------------------------------------------------------按不同的K&C工况开始进行输出---------------------------------------------------------------------%
%                                                                                                                                                                                   %
% 1.parallel_travel   2.opposite_travel   3.steering   4.static_loads_lat   5.static_load_long   6.static_load_align_torque                                                         %
%                                                                                                                                                                                   %
%                                                                                                                                                                                   %
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%

%------------------------------------------------------------Ride工况--------------------------------------------------------------------------------
if contains(filename2,'parallel_travel')
    Susp_parallel_travel_colPro={'下跳极限','整备状态','满载状态','上跳极限'};
    Susp_parallel_travel_name={'Toe Angle(deg)','Ride Toe-in(deg/m)','Camber Angle(deg)','Ride Camber(deg/m)','Caster Angle(deg)','Kingpin Incl Angle(deg)','Caster Moment Arm(mm)','Scrub Radius(mm)','Tire Contact Point_X(mm)','Ride Wheel base(mm/m)','Tire Contact Point Y(mm)',...
        'Wheel Center Base(mm)','Wheel Center Track(mm)','Total Track(mm)','Ride Track(mm/m)','Roll Steer','Roll Camber Coefficient','Roll Center Hight','Anti Dive','Anti Lift','Susp Roll Rate','Total Roll Rate',...
        'Wheel Rate','Ride Rate','Tire Load','Wheel Travel'}';
    Susp_parallel_travel_ID=[toe_angle_ID(1),camber_angle_ID(1),caster_angle_ID(1),kingpin_incl_angle_ID(1),caster_moment_arm_ID(1),scrub_radius_ID(1),left_tire_contact_point_ID(1),left_tire_contact_point_ID(2)...
        wheel_travel_base_ID(1),wheel_travel_track_ID(1),total_track_ID,roll_steer_ID(1),roll_camber_coefficient_ID(1),roll_center_location_ID(2),anti_dive_ID(1),anti_lift_ID(1),susp_roll_rate_ID,total_roll_rate_ID,...
        wheel_rate_ID(1),ride_rate_ID(1),left_tire_forces_ID(3),wheel_travel_ID(1)];

    Susp_parallel_travel_data1=quasiStatic_data(:,Susp_parallel_travel_ID);% 按ID号的顺序建立矩阵，行为时间步
    Susp_parallel_travel_data1(:,1:4)=Susp_parallel_travel_data1(:,1:4)*180/pi; % 把 toe camber caster kingpin 的输出弧度值转为角度
    Susp_parallel_travel_data1(:,end-5:end-4)=Susp_parallel_travel_data1(:,end-5:end-4)*pi/180/1000; % 从ID表最后一个向前数第5和第4 susp roll rate 和 total rate 从mm/弧度 转为 m/deg

    %                 Wheel_Load=str2double(Input_para{2})*9.8/2; % wheel load为满载状态单边轮荷
    Wheel_Load=Input_MaxLoad*9.8/2;

    [Row_Data,Row_No]=min(abs(Susp_parallel_travel_data1(:,end))); % % 通过对轮跳时间步的绝对值最小值将指针定位到整备0位置
    [Row_Data1,Row_No1]=min(abs(Susp_parallel_travel_data1(:,end-1)-Wheel_Load)); % 轮胎力的绝对值减去轮荷 的最小值定位指针1为满载状态的0位置
    [Row_Data2g,Row_No2g]=min(abs(Susp_parallel_travel_data1(:,end-1)-Wheel_Load*2)); % 轮胎力的绝对值减去轮荷 的最小值定位指针1为满载状态的0位置

    %----------------计算几个瞬态位置的参数结果--------------
    %计算下跳极限位置的toe change
    Ride_Toe_in(1)=1000*(Susp_parallel_travel_data1(2,1)-Susp_parallel_travel_data1(1,1))/(Susp_parallel_travel_data1(2,end)-Susp_parallel_travel_data1(1,end));
    %计算整备0位置的toe change
    Ride_Toe_in(Row_No)=1000*(Susp_parallel_travel_data1(Row_No+1,1)-Susp_parallel_travel_data1(Row_No-1,1))/(Susp_parallel_travel_data1(Row_No+1,end)-Susp_parallel_travel_data1(Row_No-1,end));
    %计算满载状态0位置的toe change
    Ride_Toe_in(Row_No1)=1000*(Susp_parallel_travel_data1(Row_No1+1,1)-Susp_parallel_travel_data1(Row_No1-1,1))/(Susp_parallel_travel_data1(Row_No1+1,end)-Susp_parallel_travel_data1(Row_No1-1,end));
    %计算满载状态0位置的toe change
    Ride_Toe_in(RowNo)=1000*(Susp_parallel_travel_data1(end,1)-Susp_parallel_travel_data1(end-1,1))/(Susp_parallel_travel_data1(end,end)-Susp_parallel_travel_data1(end-1,end));
    %计算bump/rebound 50mm 位置的toe 角 (如果分析步=100, 同时设定100mm上跳，即 101行数据中第51行为0位置，第26行为rebound 50mm 位置，第76行为bump 50mm 位置)
    Bump_toe_bump_50 = Susp_parallel_travel_data1(76,1);
    app.ToeCha50mmEditField.Value = Bump_toe_bump_50;
    Bump_toe_rebound_50 = Susp_parallel_travel_data1(26,1);
    app.ToeCha50mmEditField_2.Value = Bump_toe_rebound_50;
    %计算2g halfload时的上跳行程
    Bump_2g_WheelTravel = Susp_parallel_travel_data1(Row_No2g,end);
    app.WheelTravel2gHLEditField.Value = Bump_2g_WheelTravel;
    %计算2g halfload时的wheel rate
    Bump_2g_WheelRate = Susp_parallel_travel_data1(Row_No2g,end-3);
    app.WheelRate2gHLEditField.Value = Bump_2g_WheelRate;

    Ride_Camber(1)=1000*(Susp_parallel_travel_data1(2,2)-Susp_parallel_travel_data1(1,2))/(Susp_parallel_travel_data1(2,end)-Susp_parallel_travel_data1(1,end));
    Ride_Camber(Row_No)=1000*(Susp_parallel_travel_data1(Row_No+1,2)-Susp_parallel_travel_data1(Row_No-1,2))/(Susp_parallel_travel_data1(Row_No+1,end)-Susp_parallel_travel_data1(Row_No-1,end));
    Ride_Camber(Row_No1)=1000*(Susp_parallel_travel_data1(Row_No1+1,2)-Susp_parallel_travel_data1(Row_No1-1,2))/(Susp_parallel_travel_data1(Row_No1+1,end)-Susp_parallel_travel_data1(Row_No1-1,end));
    Ride_Camber(RowNo)=1000*(Susp_parallel_travel_data1(end,2)-Susp_parallel_travel_data1(end-1,2))/(Susp_parallel_travel_data1(end,end)-Susp_parallel_travel_data1(end-1,end-1));

    Ride_Wheel_base(1)=1000*(Susp_parallel_travel_data1(2,7)-Susp_parallel_travel_data1(1,7))/(Susp_parallel_travel_data1(2,end)-Susp_parallel_travel_data1(1,end));
    Ride_Wheel_base(Row_No)=1000*(Susp_parallel_travel_data1(Row_No+1,7)-Susp_parallel_travel_data1(Row_No-1,7))/(Susp_parallel_travel_data1(Row_No+1,end)-Susp_parallel_travel_data1(Row_No-1,end));
    Ride_Wheel_base(Row_No1)=1000*(Susp_parallel_travel_data1(Row_No1+1,7)-Susp_parallel_travel_data1(Row_No1-1,7))/(Susp_parallel_travel_data1(Row_No1+1,end)-Susp_parallel_travel_data1(Row_No1-1,end));
    Ride_Wheel_base(RowNo)=1000*(Susp_parallel_travel_data1(end,7)-Susp_parallel_travel_data1(end-1,7))/(Susp_parallel_travel_data1(end,end)-Susp_parallel_travel_data1(end-1,end));

    Ride_Wheel_track(1)=1000*(Susp_parallel_travel_data1(2,11)-Susp_parallel_travel_data1(1,11))/(Susp_parallel_travel_data1(2,end)-Susp_parallel_travel_data1(1,end));
    Ride_Wheel_track(Row_No)=1000*(Susp_parallel_travel_data1(Row_No+1,11)-Susp_parallel_travel_data1(Row_No-1,11))/(Susp_parallel_travel_data1(Row_No+1,end)-Susp_parallel_travel_data1(Row_No-1,end));
    Ride_Wheel_track(Row_No1)=1000*(Susp_parallel_travel_data1(Row_No1+1,11)-Susp_parallel_travel_data1(Row_No1-1,11))/(Susp_parallel_travel_data1(Row_No1+1,end)-Susp_parallel_travel_data1(Row_No1-1,end));
    Ride_Wheel_track(RowNo)=1000*(Susp_parallel_travel_data1(end,11)-Susp_parallel_travel_data1(end-1,11))/(Susp_parallel_travel_data1(end,end)-Susp_parallel_travel_data1(end-1,end));

    Susp_parallel_travel_data=[Susp_parallel_travel_data1(:,1),Ride_Toe_in',Susp_parallel_travel_data1(:,2),Ride_Camber',Susp_parallel_travel_data1(:,3:7),Ride_Wheel_base',...
        Susp_parallel_travel_data1(:,8:11),Ride_Wheel_track',Susp_parallel_travel_data1(:,12:end)];

    %                 if ~isempty(Input_para{1}) && ~isempty(Input_para{2}) && ~isempty(Input_para{3})
    %                     Wheel_Kerb=str2double(Input_para{1})/2;
    Wheel_Kerb=Input_HalfLoad/2;
    %                     Wheel_Mass=str2double(Input_para{2})/2;
    Wheel_Mass=Input_MaxLoad/2
    %                     Mass_nospring=str2double(Input_para{3})/2;
    Mass_nospring=Input_Unsprung/2;
    Ride_rate=Susp_parallel_travel_data([Row_No,Row_No1],end-2);
    Freq_susp=sqrt(Ride_rate(1)*1000/(Wheel_Kerb-Mass_nospring))/(2*pi);
    Freq_susp1=sqrt(Ride_rate(2)*1000/(Wheel_Mass-Mass_nospring))/(2*pi);
    %xlswrite(filename1,{'车身偏频','',Freq_susp,Freq_susp1,''},1,'A28');
    %                 end

    %改造data1的结构，在第一列后加入一列 toe in, 在原来第2列后加入一列 ridecamber, 原来3-7列不变，再加入 ride
    %wheel base 和 track
    %xlswrite(filename1,Susp_parallel_travel_name,1,'A2'); %从excel 的sheet1 的A2开始，依次把travel name 列上，由于trave name是列向量，所以excel也是列
    %xlswrite(filename1,Susp_parallel_travel_colPro,1,'B1'); %从excel 的sheet1 的B1开始，依次把travel colpro 列上，由于colpro是行向量，所以excel也是行
    %xlswrite(filename1,Susp_parallel_travel_data([1,Row_No,Row_No1,end],:)',1,'B2');

    %------------------------------------------------------------Ride工况的画图----------------------------------------------------------------------
    %--------------------------------col 1------------col 2----------------col 3--------------------------col 4------------------------col 5-------
    Susp_parallel_travel_plot_ID=[toe_angle_ID(1),toe_angle_ID(2),left_tire_contact_point_ID(2),right_tire_contact_point_ID(2),wheel_travel_base_ID(1),...
        wheel_travel_base_ID(2),wheel_travel_track_ID(1),wheel_travel_track_ID(2), anti_dive_ID(1), anti_dive_ID(2),anti_lift_ID(1),anti_lift_ID(2),...
        wheel_rate_ID(1),wheel_rate_ID(2),camber_angle_ID(1),camber_angle_ID(2),wheel_travel_ID(1),wheel_travel_ID(2),wheel_load_vertical_force_ID(1),...
        wheel_load_vertical_force_ID(2), side_view_swing_arm_angle_ID(1),side_view_swing_arm_angle_ID(2),side_view_swing_arm_length_ID(1),side_view_swing_arm_length_ID(2),caster_angle_ID(1),caster_angle_ID(2)];

    Susp_parallel_travel_plot_data1=quasiStatic_data(:,Susp_parallel_travel_plot_ID);
    Susp_parallel_travel_plot_data1(:,1:2)=Susp_parallel_travel_plot_data1(:,1:2)*180/pi;
    Susp_parallel_travel_plot_data1(:,15:16)=Susp_parallel_travel_plot_data1(:,15:16)*180/pi;
    Susp_parallel_travel_plot_data1(:,21:22)=Susp_parallel_travel_plot_data1(:,21:22)*180/pi;
    Susp_parallel_travel_plot_data1(:,25:26)=Susp_parallel_travel_plot_data1(:,25:26)*180/pi;

    %------------------------------------------------------------------------------------------------------------------------
    % toe change
    %------------------------------------------------------------------------------------------------------------------------
    P_R_B_toe_change_left=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,1),1);
    P_R_B_toe_change_right=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,2),1);

    app.BumpSteerEditField.Value =(round(P_R_B_toe_change_left(1,1)*1000,2)+round(P_R_B_toe_change_right(1,1)*1000,2))/2;

    %left---------------------------------------------------

    hold(app.UIAxesLeft_R_B_toe,'on');


    plot(app.UIAxesLeft_R_B_toe,Susp_parallel_travel_plot_data1(:,17),Susp_parallel_travel_plot_data1(:,1),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_B_toe,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),P_R_B_toe_change_left(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17)+P_R_B_toe_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1,(2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

    ylabel(app.UIAxesLeft_R_B_toe,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_B_toe,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_B_toe.YAxis.FontSize=10;
    app.UIAxesLeft_R_B_toe.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_B_toe,'Bump Steer Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_R_B_toe,'on');

    set(app.UIAxesLeft_R_B_toe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');
  
    legend_R_B_toe_left = legend(app.UIAxesLeft_R_B_toe,'show');
    set(legend_R_B_toe_left,'Location','best');

    text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(P_R_B_toe_change_left(1,1),4))  '*x+' num2str(round(P_R_B_toe_change_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_B_toe);

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_B_toe);
    text(0.03, 0.55,'toe out <<                                          >> toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_B_toe);

    hold(app.UIAxesLeft_R_B_toe,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_B_toe,'on');

    plot(app.UIAxesRight_R_B_toe,Susp_parallel_travel_plot_data1(:,18),Susp_parallel_travel_plot_data1(:,2),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_R_B_toe,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),P_R_B_toe_change_right(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18)+P_R_B_toe_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_R_B_toe,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_B_toe,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_B_toe.YAxis.FontSize=10;
    app.UIAxesRight_R_B_toe.XAxis.FontSize=10;

    title(app.UIAxesRight_R_B_toe,'Bump Steer Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_R_B_toe,'on');

    set(app.UIAxesRight_R_B_toe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_toe_right = legend(app.UIAxesRight_R_B_toe,'show');
    set(legend_toe_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(P_R_B_toe_change_right(1,1),4))  '*x+' num2str(round(P_R_B_toe_change_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_B_toe);

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_B_toe);
    text(0.03, 0.55,'toe out <<                                          >> toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_B_toe);
    
    hold(app.UIAxesRight_R_B_toe,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % Camber change
    %------------------------------------------------------------------------------------------------------------------------
    P_R_B_camber_change_left=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,15),1);
    P_R_B_camber_change_right=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,16),1);

    app.BumpCamberEditField.Value =(round(P_R_B_camber_change_left(1,1)*1000,2)+round(P_R_B_camber_change_right(1,1)*1000,2))/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_B_camber,'on');

    plot(app.UIAxesLeft_R_B_camber,Susp_parallel_travel_plot_data1(:,17),Susp_parallel_travel_plot_data1(:,15),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_B_camber,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),P_R_B_camber_change_left(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17)+P_R_B_camber_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_R_B_camber,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold','HorizontalAlignment','center');
    xlabel(app.UIAxesLeft_R_B_camber,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_B_camber.YAxis.FontSize=10;
    app.UIAxesLeft_R_B_camber.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_B_camber,'Bump Camber Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_R_B_camber,'on');

    set(app.UIAxesLeft_R_B_camber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_camber_left = legend(app.UIAxesLeft_R_B_camber,'show');
    set(legend_camber_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_B_camber_change_left(1,1))  '*x+' num2str(P_R_B_camber_change_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_B_camber)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_B_camber);
    text(0.03, 0.55,'top in <<                                          >> top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_B_camber);
    
    hold(app.UIAxesLeft_R_B_camber,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_B_camber,'on');

    plot(app.UIAxesRight_R_B_camber,Susp_parallel_travel_plot_data1(:,18),Susp_parallel_travel_plot_data1(:,16),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_R_B_camber,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),P_R_B_camber_change_right(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18)+P_R_B_camber_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_R_B_camber,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_B_camber,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_B_camber.YAxis.FontSize=10;
    app.UIAxesRight_R_B_camber.XAxis.FontSize=10;

    title(app.UIAxesRight_R_B_camber,'Bump Camber Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_R_B_camber,'on');

    set(app.UIAxesRight_R_B_camber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_camber_right = legend(app.UIAxesRight_R_B_camber,'show');
    set(legend_camber_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_B_camber_change_right(1,1))  '*x+' num2str(P_R_B_camber_change_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_B_camber)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_B_camber);
    text(0.03, 0.55,'top in <<                                          >> top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_B_camber);
    
    hold(app.UIAxesRight_R_B_camber,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % Wheel Rate Slope@WC (Instant. Wheel Rate vs. WC vertical travel)
    % 使用与拟合完全一致的范围来绘制直线，保证拟合线穿过拟合区间两端的数据点
    %------------------------------------------------------------------------------------------------------------------------
    bumpRange = app.EditField_R_bump_range.Value;

    P_R_B_Wheelrate_change_left  = polyfit( ...
        Susp_parallel_travel_plot_data1(Row_No-bumpRange:Row_No+bumpRange,17), ...
        Susp_parallel_travel_plot_data1(Row_No-bumpRange:Row_No+bumpRange,13), 1);
    P_R_B_Wheelrate_change_right = polyfit( ...
        Susp_parallel_travel_plot_data1(Row_No-bumpRange:Row_No+bumpRange,18), ...
        Susp_parallel_travel_plot_data1(Row_No-bumpRange:Row_No+bumpRange,14), 1);

    app.WheelRateSlopeWCEditField.Value = ( ...
        round(P_R_B_Wheelrate_change_left(1,1),2) + ...
        round(P_R_B_Wheelrate_change_right(1,1),2) ) / 2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_B_Wheelrate,'on');

    plot(app.UIAxesLeft_R_B_Wheelrate, ...
        Susp_parallel_travel_plot_data1(:,17), ...
        Susp_parallel_travel_plot_data1(:,13), ...
        'DisplayName','Result', ...
        'Color',app.ColorPicker_curve.Value, ...
        'LineWidth', 1.5);

    plot(app.UIAxesLeft_R_B_Wheelrate, ...
        Susp_parallel_travel_plot_data1(Row_No-bumpRange:Row_No+bumpRange,17), ...
        P_R_B_Wheelrate_change_left(1,1) * Susp_parallel_travel_plot_data1(Row_No-bumpRange:Row_No+bumpRange,17) + P_R_B_Wheelrate_change_left(1,2), ...
        'DisplayName',['curve fitting [' num2str(-2*bumpRange) 'mm, ' num2str(2*bumpRange) 'mm]'], ...
        'MarkerIndices',[1 (2*bumpRange+1)], ...
        'Marker','o', ...
        'Color',[0 0 1]);

    ylabel(app.UIAxesLeft_R_B_Wheelrate,'Wheel Rate [N/mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_B_Wheelrate,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_B_Wheelrate.YAxis.FontSize = 10;
    app.UIAxesLeft_R_B_Wheelrate.XAxis.FontSize = 10;

    title(app.UIAxesLeft_R_B_Wheelrate,'Instant. Wheel Rate Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_R_B_Wheelrate,'on');

    set(app.UIAxesLeft_R_B_Wheelrate,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_Wheelrate_left = legend(app.UIAxesLeft_R_B_Wheelrate,'show');
    set(legend_Wheelrate_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value, ...
        ['Wheel Rate change =' num2str(P_R_B_Wheelrate_change_left(1,1)) ' N/mm/mm'], ...
        'Units', 'normalized', ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Color',app.ColorPicker_fit.Value, ...
        'FontSize',10, ...
        'FontName','Times New Roman', ...
        'Parent',app.UIAxesLeft_R_B_Wheelrate);

    text(0.55, 0.01, ...
        'rebound <<                                                          >> bump', ...
        'Units', 'normalized', ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize',10, ...
        'FontName','Times New Roman', ...
        'FontWeight', 'bold', ...
        'Parent',app.UIAxesLeft_R_B_Wheelrate);
    
    hold(app.UIAxesLeft_R_B_Wheelrate,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_B_Wheelrate,'on');

    plot(app.UIAxesRight_R_B_Wheelrate, ...
        Susp_parallel_travel_plot_data1(:,18), ...
        Susp_parallel_travel_plot_data1(:,14), ...
        'DisplayName','Result', ...
        'Color',app.ColorPicker_curve.Value, ...
        'LineWidth', 1.5);

    plot(app.UIAxesRight_R_B_Wheelrate, ...
        Susp_parallel_travel_plot_data1(Row_No-bumpRange:Row_No+bumpRange,18), ...
        P_R_B_Wheelrate_change_right(1,1) * Susp_parallel_travel_plot_data1(Row_No-bumpRange:Row_No+bumpRange,18) + P_R_B_Wheelrate_change_right(1,2), ...
        'DisplayName',['curve fitting [' num2str(-2*bumpRange) 'mm, ' num2str(2*bumpRange) 'mm]'], ...
        'MarkerIndices',[1 (2*bumpRange+1)], ...
        'Marker','o', ...
        'Color',[0 0 1]);

    ylabel(app.UIAxesRight_R_B_Wheelrate,'Wheel Rate [N/mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_B_Wheelrate,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_B_Wheelrate.YAxis.FontSize = 10;
    app.UIAxesRight_R_B_Wheelrate.XAxis.FontSize = 10;

    title(app.UIAxesRight_R_B_Wheelrate,'Instant. Wheel Rate Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_R_B_Wheelrate,'on');

    set(app.UIAxesRight_R_B_Wheelrate,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_Wheelrate_right = legend(app.UIAxesRight_R_B_Wheelrate,'show');
    set(legend_Wheelrate_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value, ...
        ['Wheel Rate change ='  num2str(P_R_B_Wheelrate_change_right(1,1)) ' N/mm/mm'], ...
        'Units', 'normalized', ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Color',app.ColorPicker_fit.Value, ...
        'FontSize',10, ...
        'FontName','Times New Roman', ...
        'Parent',app.UIAxesRight_R_B_Wheelrate);

    text(0.55, 0.01, ...
        'rebound <<                                                          >> bump', ...
        'Units', 'normalized', ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize',10, ...
        'FontName','Times New Roman', ...
        'FontWeight', 'bold', ...
        'Parent',app.UIAxesRight_R_B_Wheelrate);
    
    hold(app.UIAxesRight_R_B_Wheelrate,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % wheel recession change
    %------------------------------------------------------------------------------------------------------------------------
    P_R_B_WB_change_left=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,5),1);
    P_WB_R_B_change_right=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,6),1);

    app.WheelRecessionEditField.Value =(round(P_R_B_WB_change_left(1,1)*1000,2)+round(P_WB_R_B_change_right(1,1)*1000,2))/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_B_WB,'on');

    plot(app.UIAxesLeft_R_B_WB,Susp_parallel_travel_plot_data1(:,17),Susp_parallel_travel_plot_data1(:,5),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_B_WB,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),P_R_B_WB_change_left(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17)+P_R_B_WB_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_R_B_WB,'wheel recession (wheel centre X disp.) [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_B_WB,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_B_WB.YAxis.FontSize=10;
    app.UIAxesLeft_R_B_WB.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_B_WB,'Wheel Recession Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_R_B_WB,'on');

    set(app.UIAxesLeft_R_B_WB,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_WB_left = legend(app.UIAxesLeft_R_B_WB,'show');
    set(legend_WB_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_B_WB_change_left(1,1))  '*x+' num2str(P_R_B_WB_change_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_B_WB)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_B_WB);
    text(0.03, 0.55,'forwards <<                                      >> backwards','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_B_WB);
    
    hold(app.UIAxesLeft_R_B_WB,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_B_WB,'on');

    plot(app.UIAxesRight_R_B_WB,Susp_parallel_travel_plot_data1(:,18),Susp_parallel_travel_plot_data1(:,6),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_R_B_WB,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),P_WB_R_B_change_right(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18)+P_WB_R_B_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_R_B_WB,'wheel recession (wheel centre X disp.) [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_B_WB,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_B_WB.YAxis.FontSize=10;
    app.UIAxesRight_R_B_WB.XAxis.FontSize=10;

    title(app.UIAxesRight_R_B_WB,'Wheel Recession Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_R_B_WB,'on');

    set(app.UIAxesRight_R_B_WB,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_WB_right = legend(app.UIAxesRight_R_B_WB,'show');
    set(legend_WB_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_WB_R_B_change_right(1,1))  '*x+' num2str(P_WB_R_B_change_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_B_WB)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_B_WB);
    text(0.03, 0.55,'forwards <<                                      >> backwards','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_B_WB);
    
    hold(app.UIAxesRight_R_B_WB,'off');

    %------------------------------------------------------------------------------------------------------------------------
    % track change
    %------------------------------------------------------------------------------------------------------------------------
    P_Track_change_left=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,7),1);
    P_Track_change_right=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,8),1);

    app.TrackChangeEditField.Value =(round(P_Track_change_left(1,1)*-1000,2)+round(P_Track_change_right(1,1)*1000,2))/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_Track,'on');

    plot(app.UIAxesLeft_Track,Susp_parallel_travel_plot_data1(:,17),Susp_parallel_travel_plot_data1(:,7),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_Track,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),P_Track_change_left(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17)+P_Track_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_Track,'wheel centre Y disp. [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_Track,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_Track.YAxis.FontSize=10;
    app.UIAxesLeft_Track.XAxis.FontSize=10;

    title(app.UIAxesLeft_Track,'Lateral Wheel Centre Displacement Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_Track,'on');

    set(app.UIAxesLeft_Track,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_Track_left = legend(app.UIAxesLeft_Track,'show');
    set(legend_Track_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_Track_change_left(1,1))  '*x+' num2str(P_Track_change_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_Track)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_Track);
    text(0.03, 0.55,'left <<                                              >> right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_Track);
    
    hold(app.UIAxesLeft_Track,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_Track,'on');

    plot(app.UIAxesRight_Track,Susp_parallel_travel_plot_data1(:,18),Susp_parallel_travel_plot_data1(:,8),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_Track,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),P_Track_change_right(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18)+P_Track_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_Track,'wheel centre Y disp. [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_Track,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_Track.YAxis.FontSize=10;
    app.UIAxesRight_Track.XAxis.FontSize=10;

    title(app.UIAxesRight_Track,'Lateral Wheel Centre Displacement Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_Track,'on');

    set(app.UIAxesRight_Track,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_Track_right = legend(app.UIAxesRight_Track,'show');
    set(legend_Track_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_Track_change_right(1,1))  '*x+' num2str(P_Track_change_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_Track)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_Track);
    text(0.03, 0.55,'left <<                                              >> right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_Track);
    
    hold(app.UIAxesRight_Track,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % castor change
    %------------------------------------------------------------------------------------------------------------------------
    P_Castor_change_left=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,25),1);
    P_Castor_change_right=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,26),1);

    app.SpringAngleEditField.Value =(round(P_Castor_change_left(1,2),2)+round(P_Castor_change_right(1,2),2))/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_Castor,'on');

    plot(app.UIAxesLeft_Castor,Susp_parallel_travel_plot_data1(:,17),Susp_parallel_travel_plot_data1(:,25),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_Castor,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),P_Castor_change_left(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17)+P_Castor_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_Castor,'castor angle[°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_Castor,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_Castor.YAxis.FontSize=10;
    app.UIAxesLeft_Castor.XAxis.FontSize=10;

    title(app.UIAxesLeft_Castor,'Castor Angle Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_Castor,'on');

    set(app.UIAxesLeft_Castor,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_Castor_left = legend(app.UIAxesLeft_Castor,'show');
    set(legend_Castor_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_Castor_change_left(1,1))  '*x+' num2str(P_Castor_change_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_Castor)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_Castor);
    text(0.03, 0.55,'rolling backward <<                        >> rolling forward','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_Castor);
    
    hold(app.UIAxesLeft_Castor,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_Castor,'on');

    plot(app.UIAxesRight_Castor,Susp_parallel_travel_plot_data1(:,18),Susp_parallel_travel_plot_data1(:,26),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_Castor,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),P_Castor_change_right(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18)+P_Castor_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_Castor,'castor angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_Castor,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_Castor.YAxis.FontSize=10;
    app.UIAxesRight_Castor.XAxis.FontSize=10;

    title(app.UIAxesRight_Castor,'Castor Angle Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_Castor,'on');

    set(app.UIAxesRight_Castor,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_Castor_right = legend(app.UIAxesRight_Castor,'show');
    set(legend_Castor_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_Castor_change_right(1,1))  '*x+' num2str(P_Castor_change_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_Castor)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_Castor);
    text(0.03, 0.55,'rolling forward <<                        >> rolling backward','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_Castor);
    
    hold(app.UIAxesRight_Castor,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % side swing arm angle change
    %------------------------------------------------------------------------------------------------------------------------
    P_swa_change_left=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,21),1);
    P_swa_change_right=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,22),1);

    app.SVSAAngleEditField.Value =(round(P_swa_change_left(1,2),3)+round(P_swa_change_right(1,2),3))/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_swa,'on');

    plot(app.UIAxesLeft_swa,Susp_parallel_travel_plot_data1(:,17),Susp_parallel_travel_plot_data1(:,21),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_swa,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),P_swa_change_left(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17)+P_swa_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_swa,'side swing arm angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_swa,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_swa.YAxis.FontSize=10;
    app.UIAxesLeft_swa.XAxis.FontSize=10;

    title(app.UIAxesLeft_swa,'Side Swing Arm Angle Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_swa,'on');

    set(app.UIAxesLeft_swa,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_swa_left = legend(app.UIAxesLeft_swa,'show');
    set(legend_swa_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_swa_change_left(1,1))  '*x+' num2str(P_swa_change_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_swa)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_swa);
    
    hold(app.UIAxesLeft_swa,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_swa,'on');

    plot(app.UIAxesRight_swa,Susp_parallel_travel_plot_data1(:,18),Susp_parallel_travel_plot_data1(:,22),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_swa,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),P_swa_change_right(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18)+P_swa_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_swa,'side swing arm angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_swa,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_swa.YAxis.FontSize=10;
    app.UIAxesRight_swa.XAxis.FontSize=10;

    title(app.UIAxesRight_swa,'Side Swing Arm Angle Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_swa,'on');

    set(app.UIAxesRight_swa,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_swa_right = legend(app.UIAxesRight_swa,'show');
    set(legend_swa_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_swa_change_right(1,1))  '*x+' num2str(P_swa_change_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_swa)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_swa);
    
    hold(app.UIAxesRight_swa,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % side swing arm length change
    %------------------------------------------------------------------------------------------------------------------------
    P_swl_change_left=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,23),1);
    P_swl_change_right=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,24),1);

    app.SVSALengthEditField.Value =(round(P_swl_change_left(1,2),3)+round(P_swl_change_right(1,2),3))/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_swl,'on');

    plot(app.UIAxesLeft_swl,Susp_parallel_travel_plot_data1(:,17),Susp_parallel_travel_plot_data1(:,23),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_swl,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),P_swl_change_left(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17)+P_swl_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_swl,'side swing arm length variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_swl,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_swl.YAxis.FontSize=10;
    app.UIAxesLeft_swl.XAxis.FontSize=10;

    title(app.UIAxesLeft_swl,'Side Swing Arm Length Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_swl,'on');

    set(app.UIAxesLeft_swl,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_swl_left = legend(app.UIAxesLeft_swl,'show');
    set(legend_swl_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_swl_change_left(1,1))  '*x+' num2str(P_swl_change_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_swl)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_swl);
    
    hold(app.UIAxesLeft_swl,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_swl,'on');

    plot(app.UIAxesRight_swl,Susp_parallel_travel_plot_data1(:,18),Susp_parallel_travel_plot_data1(:,24),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_swl,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),P_swl_change_right(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18)+P_swl_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_swl,'side swing arm length variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_swl,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_swl.YAxis.FontSize=10;
    app.UIAxesRight_swl.XAxis.FontSize=10;

    title(app.UIAxesRight_swl,'Side Swing Arm Length Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_swl,'on');

    set(app.UIAxesRight_swl,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_swl_right = legend(app.UIAxesRight_swl,'show');
    set(legend_swl_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_swl_change_right(1,1))  '*x+' num2str(P_swl_change_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_swl)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_swl);
    
    hold(app.UIAxesRight_swl,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % vertical force change
    %------------------------------------------------------------------------------------------------------------------------
    P_wheelload_change_left=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,19),1);
    P_wheelload_change_right=polyfit(Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,20),1);

    app.WheelRateWCEditField.Value =(round(P_wheelload_change_left(1,1),2)+round(P_wheelload_change_right(1,1),2))/2;

    app.SuspensionFreqEditField.Value = sqrt(((round(P_wheelload_change_left(1,1),2)+round(P_wheelload_change_right(1,1),2))*1000/2)/((Input_HalfLoad-Input_Unsprung)/2))/(2*pi);

    %left---------------------------------------------------
    hold(app.UIAxesLeft_wheelload,'on');

    plot(app.UIAxesLeft_wheelload,Susp_parallel_travel_plot_data1(:,17),Susp_parallel_travel_plot_data1(:,19),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_wheelload,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17),P_wheelload_change_left(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,17)+P_wheelload_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_wheelload,'wheel load [N]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_wheelload,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_wheelload.YAxis.FontSize=10;
    app.UIAxesLeft_wheelload.XAxis.FontSize=10;

    title(app.UIAxesLeft_wheelload,'Wheel Rate Left','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesLeft_wheelload,'on');

    set(app.UIAxesLeft_wheelload,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_wheelload_left = legend(app.UIAxesLeft_wheelload,'show');
    set(legend_wheelload_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_wheelload_change_left(1,1))  '*x+' num2str(P_wheelload_change_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_wheelload)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_wheelload);
    
    hold(app.UIAxesLeft_wheelload,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_wheelload,'on');

    plot(app.UIAxesRight_wheelload,Susp_parallel_travel_plot_data1(:,18),Susp_parallel_travel_plot_data1(:,20),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_wheelload,Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18),P_wheelload_change_right(1,1)*Susp_parallel_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,18)+P_wheelload_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_wheelload,'wheel load [N]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_wheelload,'@WC vertical travel [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_wheelload.YAxis.FontSize=10;
    app.UIAxesRight_wheelload.XAxis.FontSize=10;

    title(app.UIAxesRight_wheelload,'Wheel Rate Right','HorizontalAlignment','center','FontWeight','bold');

    box(app.UIAxesRight_wheelload,'on');

    set(app.UIAxesRight_wheelload,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_wheelload_right = legend(app.UIAxesRight_wheelload,'show');
    set(legend_wheelload_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_wheelload_change_right(1,1))  '*x+' num2str(P_wheelload_change_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_wheelload)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_wheelload);
    
    hold(app.UIAxesRight_wheelload,'off');


    %重置内存
    %     clear quasiStatic_data Susp_parallel_travel_data1 Susp_parallel_travel_data...
    %         Ride_Toe_in Ride_Camber Ride_Wheel_base Ride_Wheel_track;
else
end

fclose('all');
