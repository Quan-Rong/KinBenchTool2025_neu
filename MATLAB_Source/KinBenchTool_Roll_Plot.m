if isempty(app.EditField_browser_R_roll.Value)
    uialert(app.UIFigure, 'please select a file!', 'Error');
    return;
end
%clc,clear;

% 定位res文件，定位文件路径和文件名
steps=0;
filedir = app.EditField_browser_R_roll.Value;
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
expression = '\d*';
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

%------------------------------------------------------------ROLL工况--------------------------------------------------------------------------------


if contains(filename2,'opposite_travel') || contains(filename2,'roll_angle')

    Susp_opposite_travel_name={'Toe Angle(deg)','','Camber Angle(deg)','','Roll Steer','','Roll Camber Coefficient','','Susp Roll Rate','Total Roll Rate','Roll Center Hight',...
        'Wheel Center Base(mm)','','Wheel Center Track(mm)','','Tire Contact Point_X(mm)','','Tire Contact Point_Y(mm)',''}'; %一定注意这里面是有空行的，例如 2，4，6，8，13，15，19

    Susp_opposite_travel_ID=[toe_angle_ID,camber_angle_ID,roll_steer_ID,roll_camber_coefficient_ID,susp_roll_rate_ID,total_roll_rate_ID,roll_center_location_ID(2),...
        wheel_travel_base_ID,wheel_travel_track_ID,left_tire_contact_point_ID(1),right_tire_contact_point_ID(1),left_tire_contact_point_ID(2),right_tire_contact_point_ID(2),roll_angle_ID];

    %toe angle 占1列，camber 2列，roll steeer 2列，roll camber coff 2列，所以 susproll rate 和total roll rate在第9和第10

    Susp_opposite_travel_data1=quasiStatic_data(:,Susp_opposite_travel_ID);%根据oppo travel id的顺序建立travel data1的数据处理矩阵
    Susp_opposite_travel_data1(:,1:4)=Susp_opposite_travel_data1(:,1:4)*180/pi; %将 toe, camber, roll steer, roll camber coff 4个量的单位由弧度变为角度
    Susp_opposite_travel_data1(:,9:10)=Susp_opposite_travel_data1(:,9:10)*pi/180/1000; %改变 susp roll rate 和 total roll rate 的单位
    Susp_opposite_travel_data1(:,end-1:end)=Susp_opposite_travel_data1(:,end-1:end)*180/pi;  % roll angle left 和 right 改变单位

    [Row_Data,Row_No]=min(abs(Susp_opposite_travel_data1(:,end))); % 定位到设计状态0位置

    Roll_para=(Susp_opposite_travel_data1(Row_No+1,1:4)-Susp_opposite_travel_data1(Row_No-1,1:4))./(Susp_opposite_travel_data1(Row_No+1,end-1)-Susp_opposite_travel_data1(Row_No-1,end-1));
    %计算 roll steer 左右和roll camber 左右

    %Roll_para_Name={'Roll Steer','','Roll Camber Coefficient',''}; %注意这是4列内容
    %Susp_opposite_travel_colPro={['侧倾角',Roll_angle_min,'deg'],'整备状态',['侧倾角',Roll_angle_max,'deg']};


    %------------------------------------------------------------Ride工况的画图----------------------------------------------------------------------
    %--------------------------------col 1------------col 2----------------col 3--------------------------col 4------------------------col 5-------
    Susp_oppo_travel_plot_ID=[toe_angle_ID(1),toe_angle_ID(2),camber_angle_ID(1),camber_angle_ID(2),...
        wheel_travel_ID(1),wheel_travel_ID(2),left_tire_forces_ID(3),right_tire_forces_ID(3),roll_center_location_ID(2),...
        susp_roll_rate_ID,total_roll_rate_ID,roll_angle_ID(1),roll_angle_ID(2)];

    Susp_oppo_travel_plot_data1=quasiStatic_data(:,Susp_oppo_travel_plot_ID);
    Susp_oppo_travel_plot_data1(:,1:4)=Susp_oppo_travel_plot_data1(:,1:4)*180/pi;
    Susp_oppo_travel_plot_data1(:,10:11)=Susp_oppo_travel_plot_data1(:,10:11)*pi/180/1000; %改变 susp roll rate 和 total roll rate 的单位
    Susp_oppo_travel_plot_data1(:,12:13)=Susp_oppo_travel_plot_data1(:,12:13)*180/pi; % roll angle @wc 和 @cp 改变单位

    % 计算新的两列 camber relative ground 为 camber+rollangle（CP）
    new_col1 = Susp_oppo_travel_plot_data1(:, 3) + Susp_oppo_travel_plot_data1(:, 13);  % 第3列与第13列的和
    new_col2 = Susp_oppo_travel_plot_data1(:, 4) - Susp_oppo_travel_plot_data1(:, 13);  % 第4列与第13列的cha
    % 计算左右tire force的和
    new_col3 = Susp_oppo_travel_plot_data1(:, 7) + Susp_oppo_travel_plot_data1(:, 8);  % 第4列与第13列的和

    % 将新的两列添加到矩阵的末尾
    Susp_oppo_travel_plot_data1 = [Susp_oppo_travel_plot_data1, new_col1, new_col2, new_col3];


    %------------------------------------------------------------------------------------------------------------------------
    % toe change
    %------------------------------------------------------------------------------------------------------------------------
    P_R_R_toe_change_left=polyfit(Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12),Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,1),1);
    P_R_R_toe_change_right=polyfit(Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12),Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,2),1);

    app.RollSteerEditField.Value =(round(P_R_R_toe_change_left(1,1),3)+round(P_R_R_toe_change_right(1,1),3)*-1)/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_R_toe,'on');

    plot(app.UIAxesLeft_R_R_toe,Susp_oppo_travel_plot_data1(:,12),Susp_oppo_travel_plot_data1(:,1),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_R_toe,Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12),P_R_R_toe_change_left(1,1)*Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12)+P_R_R_toe_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-app.EditField_R_roll_range.Value) '°, ' num2str(app.EditField_R_roll_range.Value) '°]'],'MarkerIndices',[1,(2*10*app.EditField_R_roll_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);
    
    ylabel(app.UIAxesLeft_R_R_toe,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_R_toe,'@WC body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_R_toe.YAxis.FontSize=10;
    app.UIAxesLeft_R_R_toe.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_R_toe,'Roll Steer Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesLeft_R_R_toe,'on');

    set(app.UIAxesLeft_R_R_toe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_R_R_toe_left = legend(app.UIAxesLeft_R_R_toe,'show');
    set(legend_R_R_toe_left,'Location','best');

    text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(P_R_R_toe_change_left(1,1),4))  '*x+' num2str(round(P_R_R_toe_change_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_R_toe);

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_R_toe);
    text(0.03, 0.55,'toe out <<                                          >> toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_R_toe);
    
    hold(app.UIAxesLeft_R_R_toe,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_R_toe,'on');

    plot(app.UIAxesRight_R_R_toe,Susp_oppo_travel_plot_data1(:,12),Susp_oppo_travel_plot_data1(:,2),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_R_R_toe,Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12),P_R_R_toe_change_right(1,1)*Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12)+P_R_R_toe_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-app.EditField_R_roll_range.Value) '°, ' num2str(app.EditField_R_roll_range.Value) '°]'],'MarkerIndices',[1 (2*10*app.EditField_R_roll_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_R_R_toe,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_R_toe,'@WC body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_R_toe.YAxis.FontSize=10;
    app.UIAxesRight_R_R_toe.XAxis.FontSize=10;

    title(app.UIAxesRight_R_R_toe,'Roll Steer Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesRight_R_R_toe,'on');

    set(app.UIAxesRight_R_R_toe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_toe_right = legend(app.UIAxesRight_R_R_toe,'show');
    set(legend_toe_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(P_R_R_toe_change_right(1,1),4))  '*x+' num2str(round(P_R_R_toe_change_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_R_toe);

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_R_toe);
    text(0.03, 0.55,'toe out <<                                          >> toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_R_toe);
    
    hold(app.UIAxesRight_R_R_toe,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % Camber change
    %------------------------------------------------------------------------------------------------------------------------
    P_R_R_camber_change_left=polyfit(Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12),Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,3),1);
    P_R_R_camber_change_right=polyfit(Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12),Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,4),1);

    app.RollCamberEditField.Value =(round(P_R_R_camber_change_left(1,1),3)+round(P_R_R_camber_change_right(1,1),3)*-1)/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_R_camber,'on');

    plot(app.UIAxesLeft_R_R_camber,Susp_oppo_travel_plot_data1(:,12),Susp_oppo_travel_plot_data1(:,3),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_R_camber,Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12),P_R_R_camber_change_left(1,1)*Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12)+P_R_R_camber_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-app.EditField_R_roll_range.Value) '°, ' num2str(app.EditField_R_roll_range.Value) '°]'],'MarkerIndices',[1 (2*10*app.EditField_R_roll_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_R_R_camber,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_R_camber,'@WC body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_R_camber.YAxis.FontSize=10;
    app.UIAxesLeft_R_R_camber.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_R_camber,'Roll Camber Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesLeft_R_R_camber,'on');

    set(app.UIAxesLeft_R_R_camber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_camber_left = legend(app.UIAxesLeft_R_R_camber,'show');
    set(legend_camber_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_R_camber_change_left(1,1))  '*x+' num2str(P_R_R_camber_change_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_R_camber)

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_R_camber);
    text(0.03, 0.55,'top in <<                                          >> top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_R_camber);
    
    hold(app.UIAxesLeft_R_R_camber,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_R_camber,'on');

    plot(app.UIAxesRight_R_R_camber,Susp_oppo_travel_plot_data1(:,12),Susp_oppo_travel_plot_data1(:,4),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_R_R_camber,Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12),P_R_R_camber_change_right(1,1)*Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,12)+P_R_R_camber_change_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-app.EditField_R_roll_range.Value) '°, ' num2str(app.EditField_R_roll_range.Value) '°]'],'MarkerIndices',[1 (2*10*app.EditField_R_roll_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_R_R_camber,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_R_camber,'@WC body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_R_camber.YAxis.FontSize=10;
    app.UIAxesRight_R_R_camber.XAxis.FontSize=10;

    title(app.UIAxesRight_R_R_camber,'Roll Camber Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesRight_R_R_camber,'on');

    set(app.UIAxesRight_R_R_camber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_camber_right = legend(app.UIAxesRight_R_R_camber,'show');
    set(legend_camber_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_R_camber_change_right(1,1))  '*x+' num2str(P_R_R_camber_change_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_R_camber)

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_R_camber);
    text(0.03, 0.55,'top in <<                                          >> top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_R_camber);
    
    hold(app.UIAxesRight_R_R_camber,'off');


    %------------------------------------------------------------------------------------------------------------------------
    % toe change (oppo wheel travel)
    %------------------------------------------------------------------------------------------------------------------------
    P_R_R_toe_wt_left=polyfit(Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,5),Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,1),1);
    P_R_R_toe_wt_right=polyfit(Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,6),Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,2),1);

    app.RollSteerWTEditField.Value =(round(P_R_R_toe_wt_left(1,1)*1000,2)+round(P_R_R_toe_wt_right(1,1)*1000,2))/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_R_toe_WT,'on');

    plot(app.UIAxesLeft_R_R_toe_WT,Susp_oppo_travel_plot_data1(:,5),Susp_oppo_travel_plot_data1(:,1),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_R_toe_WT,Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,5),P_R_R_toe_wt_left(1,1)*Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,5)+P_R_R_toe_wt_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1,(2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

    ylabel(app.UIAxesLeft_R_R_toe_WT,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_R_toe_WT,'wheel to body Z displacement [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_R_toe_WT.YAxis.FontSize=10;
    app.UIAxesLeft_R_R_toe_WT.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_R_toe_WT,'Out-of-Phase Bump Steer Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesLeft_R_R_toe_WT,'on');

    set(app.UIAxesLeft_R_R_toe_WT,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_R_R_toe_left_wt = legend(app.UIAxesLeft_R_R_toe_WT,'show');
    set(legend_R_R_toe_left_wt,'Location','best');

    text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(P_R_R_toe_wt_left(1,1),4))  '*x+' num2str(round(P_R_R_toe_wt_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_R_toe_WT);

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_R_toe_WT);
    text(0.03, 0.55,'toe out <<                                          >> toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_R_toe_WT);
    
    hold(app.UIAxesLeft_R_R_toe_WT,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_R_toe_WT,'on');

    plot(app.UIAxesRight_R_R_toe_WT,Susp_oppo_travel_plot_data1(:,6),Susp_oppo_travel_plot_data1(:,2),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_R_R_toe_WT,Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,6),P_R_R_toe_wt_right(1,1)*Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,6)+P_R_R_toe_wt_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_R_R_toe_WT,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_R_toe_WT,'wheel to body Z displacement [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_R_toe_WT.YAxis.FontSize=10;
    app.UIAxesRight_R_R_toe_WT.XAxis.FontSize=10;

    title(app.UIAxesRight_R_R_toe_WT,'Out-of-Phase Bump Steer Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesRight_R_R_toe_WT,'on');

    set(app.UIAxesRight_R_R_toe_WT,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_toe_right_WT = legend(app.UIAxesRight_R_R_toe_WT,'show');
    set(legend_toe_right_WT,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(P_R_R_toe_wt_right(1,1),4))  '*x+' num2str(round(P_R_R_toe_wt_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_R_toe_WT);

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_R_toe_WT);
    text(0.03, 0.55,'toe out <<                                          >> toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_R_toe_WT);
    
    hold(app.UIAxesRight_R_R_toe_WT,'off');
    %------------------------------------------------------------------------------------------------------------------------
    % Camber change wheel oppo travel
    %------------------------------------------------------------------------------------------------------------------------
    P_R_R_camber_wt_left=polyfit(Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,5),Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,3),1);
    P_R_R_camber_wt_right=polyfit(Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,6),Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,4),1);

    app.RollCamberWTEditField.Value =(round(P_R_R_camber_wt_left(1,1)*1000,2)+round(P_R_R_camber_wt_right(1,1)*1000,2))/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_R_camber_WT,'on');

    plot(app.UIAxesLeft_R_R_camber_WT,Susp_oppo_travel_plot_data1(:,5),Susp_oppo_travel_plot_data1(:,3),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_R_camber_WT,Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,5),P_R_R_camber_wt_left(1,1)*Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,5)+P_R_R_camber_wt_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_R_R_camber_WT,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_R_camber_WT,'wheel to body Z displacement [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_R_camber_WT.YAxis.FontSize=10;
    app.UIAxesLeft_R_R_camber_WT.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_R_camber_WT,'Out-of-Phase Bump Camber Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesLeft_R_R_camber_WT,'on');

    set(app.UIAxesLeft_R_R_camber_WT,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_camber_left_WT = legend(app.UIAxesLeft_R_R_camber_WT,'show');
    set(legend_camber_left_WT,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_R_camber_wt_left(1,1))  '*x+' num2str(P_R_R_camber_wt_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_R_camber_WT)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_R_camber_WT);
    text(0.03, 0.55,'top in <<                                          >> top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_R_camber_WT);
    
    hold(app.UIAxesLeft_R_R_camber_WT,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_R_camber_WT,'on');

    plot(app.UIAxesRight_R_R_camber_WT,Susp_oppo_travel_plot_data1(:,6),Susp_oppo_travel_plot_data1(:,4),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_R_R_camber_WT,Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,6),P_R_R_camber_wt_right(1,1)*Susp_oppo_travel_plot_data1(Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value,6)+P_R_R_camber_wt_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-2*app.EditField_R_bump_range.Value) 'mm, ' num2str(2*app.EditField_R_bump_range.Value) 'mm]'],'MarkerIndices',[1 (2*app.EditField_R_bump_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_R_R_camber_WT,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_R_camber_WT,'wheel to body Z displacement [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_R_camber_WT.YAxis.FontSize=10;
    app.UIAxesRight_R_R_camber_WT.XAxis.FontSize=10;

    title(app.UIAxesRight_R_R_camber_WT,'Out-of-Phase Bump Camber Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesRight_R_R_camber_WT,'on');

    set(app.UIAxesRight_R_R_camber_WT,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_camber_right_WT = legend(app.UIAxesRight_R_R_camber_WT,'show');
    set(legend_camber_right_WT,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_R_camber_wt_right(1,1))  '*x+' num2str(P_R_R_camber_wt_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_R_camber_WT)

    text(0.55, 0.01,'rebound <<                                                          >> bump','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_R_camber_WT);
    text(0.03, 0.55,'top in <<                                          >> top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_R_camber_WT);
    
    hold(app.UIAxesRight_R_R_camber_WT,'off');


    %------------------------------------------------------------------------------------------------------------------------
    % Camber change relative to Ground
    %------------------------------------------------------------------------------------------------------------------------
    P_R_R_camber_ground_left=polyfit(Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13),Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,14),1);
    P_R_R_camber_ground_right=polyfit(Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13),Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,15),1);

    app.RollCamberGroundEditField.Value =(round(P_R_R_camber_ground_left(1,1),3)+round(P_R_R_camber_ground_right(1,1),3)*-1)/2;

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_R_camber_ground,'on');

    plot(app.UIAxesLeft_R_R_camber_ground,Susp_oppo_travel_plot_data1(:,13),Susp_oppo_travel_plot_data1(:,14),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_R_camber_ground,Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13),P_R_R_camber_ground_left(1,1)*Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13)+P_R_R_camber_ground_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-app.EditField_R_roll_range.Value) '°, ' num2str(app.EditField_R_roll_range.Value) '°]'],'MarkerIndices',[1 (2*10*app.EditField_R_roll_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesLeft_R_R_camber_ground,'camber angle relative ground [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_R_camber_ground,'@CP body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_R_camber_ground.YAxis.FontSize=10;
    app.UIAxesLeft_R_R_camber_ground.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_R_camber_ground,'Roll Camber Relative Ground Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesLeft_R_R_camber_ground,'on');

    set(app.UIAxesLeft_R_R_camber_ground,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_camber_ground_left = legend(app.UIAxesLeft_R_R_camber_ground,'show');
    set(legend_camber_ground_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_R_camber_ground_left(1,1))  '*x+' num2str(P_R_R_camber_ground_left(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_R_camber_ground)

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_R_camber_ground);
    text(0.03, 0.55,'top in <<                                          >> top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_R_camber_ground);
    
    hold(app.UIAxesLeft_R_R_camber_ground,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_R_camber_ground,'on');

    plot(app.UIAxesRight_R_R_camber_ground,Susp_oppo_travel_plot_data1(:,13),Susp_oppo_travel_plot_data1(:,15),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesRight_R_R_camber_ground,Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13),P_R_R_camber_ground_right(1,1)*Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13)+P_R_R_camber_ground_right(1,2),...
        'DisplayName',['curve fitting [' num2str(-app.EditField_R_roll_range.Value) '°, ' num2str(app.EditField_R_roll_range.Value) '°]'],'MarkerIndices',[1 (2*10*app.EditField_R_roll_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

    ylabel(app.UIAxesRight_R_R_camber_ground,'camber angle relative ground [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_R_camber_ground,'@CP body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_R_camber_ground.YAxis.FontSize=10;
    app.UIAxesRight_R_R_camber_ground.XAxis.FontSize=10;

    title(app.UIAxesRight_R_R_camber_ground,'Roll Camber Relative Ground Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesRight_R_R_camber_ground,'on');

    set(app.UIAxesRight_R_R_camber_ground,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_camber_right = legend(app.UIAxesRight_R_R_camber_ground,'show');
    set(legend_camber_right,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(P_R_R_camber_ground_right(1,1))  '*x+' num2str(P_R_R_camber_ground_right(1,2))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_R_camber_ground)

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_R_camber_ground);
    text(0.03, 0.55,'top in <<                                          >> top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_R_camber_ground);
    
    hold(app.UIAxesRight_R_R_camber_ground,'off');

    %------------------------------------------------------------------------------------------------------------------------
    % Suspension Roll Rate / total Roll Rate
    %------------------------------------------------------------------------------------------------------------------------

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_R_Rollrate,'on');

    app.R_rollrateEditField.Value = round(Susp_oppo_travel_plot_data1(Row_No,10),2);

    plot(app.UIAxesLeft_R_R_Rollrate,Susp_oppo_travel_plot_data1(:,12),Susp_oppo_travel_plot_data1(:,10),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);

    ylabel(app.UIAxesLeft_R_R_Rollrate,'suspension roll rate [Nm/°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_R_Rollrate,'@WC body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_R_Rollrate.YAxis.FontSize=10;
    app.UIAxesLeft_R_R_Rollrate.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_R_Rollrate,'Instant. Suspension Roll Rate Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesLeft_R_R_Rollrate,'on');

    set(app.UIAxesLeft_R_R_Rollrate,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_rollrate_left = legend(app.UIAxesLeft_R_R_Rollrate,'show');
    set(legend_rollrate_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Susp. Roll Rate =' num2str(Susp_oppo_travel_plot_data1(Row_No,10)) ' Nm/°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_R_Rollrate)

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_R_Rollrate);
    
    hold(app.UIAxesLeft_R_R_Rollrate,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_R_Rollrate,'on');

    %app.R_totalrollrateEditField.Value = round(Susp_oppo_travel_plot_data1(Row_No,11),2);

    plot(app.UIAxesRight_R_R_Rollrate,Susp_oppo_travel_plot_data1(:,13),Susp_oppo_travel_plot_data1(:,11),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);

    ylabel(app.UIAxesRight_R_R_Rollrate,'total roll rate [Nm/°]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_R_Rollrate,'@CP body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_R_Rollrate.YAxis.FontSize=12;
    app.UIAxesRight_R_R_Rollrate.XAxis.FontSize=12;

    title(app.UIAxesRight_R_R_Rollrate,'Instant. Total Roll Rate Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesRight_R_R_Rollrate,'on');

    set(app.UIAxesRight_R_R_Rollrate,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_totalrollrate_left = legend(app.UIAxesRight_R_R_Rollrate,'show');
    set(legend_totalrollrate_left,'Location','best');

    text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Total Roll Rate =' num2str(Susp_oppo_travel_plot_data1(Row_No,11)) ' Nm/°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_R_Rollrate)

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_R_Rollrate);
    
    hold(app.UIAxesRight_R_R_Rollrate,'off');


    %------------------------------------------------------------------------------------------------------------------------
    % Roll Center Height / Tire Force
    %------------------------------------------------------------------------------------------------------------------------
    P_R_R_rch_change_left=polyfit(Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13),Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,9),1);

    app.RollRCHEditField.Value =round(P_R_R_rch_change_left(1,2),1);
    app.RollRCHchangeEditField.Value =round(P_R_R_rch_change_left(1,1),3);

    %left---------------------------------------------------
    hold(app.UIAxesLeft_R_R_rch,'on');

    plot(app.UIAxesLeft_R_R_rch,Susp_oppo_travel_plot_data1(:,13),Susp_oppo_travel_plot_data1(:,9),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
    plot(app.UIAxesLeft_R_R_rch,Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13),P_R_R_rch_change_left(1,1)*Susp_oppo_travel_plot_data1(Row_No-10*app.EditField_R_roll_range.Value:Row_No+10*app.EditField_R_roll_range.Value,13)+P_R_R_rch_change_left(1,2),...
        'DisplayName',['curve fitting [' num2str(-app.EditField_R_roll_range.Value) '°, ' num2str(app.EditField_R_roll_range.Value) '°]'],'MarkerIndices',[1,(2*10*app.EditField_R_roll_range.Value+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

    ylabel(app.UIAxesLeft_R_R_rch,'kin. Roll Center Height [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesLeft_R_R_rch,'@CP body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesLeft_R_R_rch.YAxis.FontSize=10;
    app.UIAxesLeft_R_R_rch.XAxis.FontSize=10;

    title(app.UIAxesLeft_R_R_rch,'Kin. Center Height','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesLeft_R_R_rch,'on');

    set(app.UIAxesLeft_R_R_rch,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_R_R_rch_left = legend(app.UIAxesLeft_R_R_rch,'show');
    set(legend_R_R_rch_left,'Location','best');

    text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(P_R_R_rch_change_left(1,1),4))  '*x+' num2str(round(P_R_R_rch_change_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_R_rch);

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_R_rch);
    
    hold(app.UIAxesLeft_R_R_rch,'off');

    %right---------------------------------------------------
    hold(app.UIAxesRight_R_R_rch,'on');

    plot(app.UIAxesRight_R_R_rch,Susp_oppo_travel_plot_data1(:,12),Susp_oppo_travel_plot_data1(:,7),'DisplayName','Tire Force Left','Color',[0.07,0.62,1.00],'LineWidth', 1.5);
    plot(app.UIAxesRight_R_R_rch,Susp_oppo_travel_plot_data1(:,12),Susp_oppo_travel_plot_data1(:,8),'DisplayName','Tire Force Right','Color',[0.39,0.83,0.07],'LineWidth', 1.5);
    plot(app.UIAxesRight_R_R_rch,Susp_oppo_travel_plot_data1(:,12),Susp_oppo_travel_plot_data1(:,16),'DisplayName','Tire Force Left+Right','Color',[0.72,0.27,1.00],'LineWidth', 1.5);


    ylabel(app.UIAxesRight_R_R_rch,'tire force normal [N]','HorizontalAlignment','center', 'FontWeight', 'bold');
    xlabel(app.UIAxesRight_R_R_rch,'@WC body roll angle [°]','HorizontalAlignment','center', 'FontWeight', 'bold');

    app.UIAxesRight_R_R_rch.YAxis.FontSize=10;
    app.UIAxesRight_R_R_rch.XAxis.FontSize=10;

    title(app.UIAxesRight_R_R_rch,'Roll Tire Force','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

    box(app.UIAxesRight_R_R_rch,'on');

    set(app.UIAxesRight_R_R_rch,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

    legend_R_R_rch_right = legend(app.UIAxesRight_R_R_rch,'show');
    set(legend_R_R_rch_right,'Location','best');

    text(0.55, 0.01,'turn left <<                                                  >> turn right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_R_rch);
    
    hold(app.UIAxesRight_R_R_rch,'off');


    %重置内存
    %clear quasiStatic_data

else
end

fclose('all');
%elapsedTime = toc(timerVal); % 如果不需要计时器，可以注释掉
%end