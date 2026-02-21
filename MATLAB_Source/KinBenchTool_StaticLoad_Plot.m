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


        %------------------------------------------------------------------------------------------------------------------------
        % lat toe change
        %------------------------------------------------------------------------------------------------------------------------

        app.lattoeEditField.Value =1000*(round(Lat_toe_cf_left(1,1),6)+round(Lat_toe_cf_right(1,1),6)*-1)/2;
        app.lattoe1000EditField.Value = Susp_static_load_data(Row_No_p0+12,1);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_lattoe,'on');

        plot(app.UIAxesLeft_R_lattoe,Susp_static_load_data(:,13),Susp_static_load_data(:,1),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_lattoe,Susp_static_load_data(Row_No_p1:Row_No_p2,13),Lat_toe_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,13)+Lat_toe_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_lat_rangeshow.Value) 'N, ' num2str(app.EditField_R_lat_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_lattoe,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_lattoe,'lateral wheel force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_lattoe.YAxis.FontSize=10;
        app.UIAxesLeft_R_lattoe.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_lattoe,'Lateral Toe Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_lattoe,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_lattoe); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_lattoe, x_ticks);

        set(app.UIAxesLeft_R_lattoe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_lattoe_left = legend(app.UIAxesLeft_R_lattoe,'show');
        set(legend_R_lattoe_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(Lat_toe_cf_left(1,1),6))  '*x+' num2str(round(Lat_toe_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_lattoe);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_lattoe);
        text(0.03, 0.5,'toe out                                      toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_lattoe);

        hold(app.UIAxesLeft_R_lattoe,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_lattoe,'on');

        plot(app.UIAxesRight_R_lattoe,Susp_static_load_data(:,14),Susp_static_load_data(:,2),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_lattoe,Susp_static_load_data(Row_No_p1:Row_No_p2,14),Lat_toe_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,14)+Lat_toe_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_lat_rangeshow.Value) 'N, ' num2str(app.EditField_R_lat_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_lattoe,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_lattoe,'lateral force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_lattoe.YAxis.FontSize=10;
        app.UIAxesRight_R_lattoe.XAxis.FontSize=10;

        title(app.UIAxesRight_R_lattoe,'Lateral Toe Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_lattoe,'on');

        xticks(app.UIAxesRight_R_lattoe, x_ticks);

        set(app.UIAxesRight_R_lattoe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend(app.UIAxesRight_R_lattoe,'show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(Lat_toe_cf_right(1,1),6))  '*x+' num2str(round(Lat_toe_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_lattoe);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_lattoe);
        text(0.03, 0.5,'toe out                                      toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_lattoe);


        hold(app.UIAxesRight_R_lattoe,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % lat camber change
        %------------------------------------------------------------------------------------------------------------------------

        app.latcamberEditField.Value =1000*(round(Lat_camber_cf_left(1,1),6)+round(Lat_camber_cf_right(1,1),6)*-1)/2;

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_latcamber,'on');

        plot(app.UIAxesLeft_R_latcamber,Susp_static_load_data(:,13),Susp_static_load_data(:,3),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_latcamber,Susp_static_load_data(Row_No_p1:Row_No_p2,13),Lat_camber_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,13)+Lat_camber_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_lat_rangeshow.Value) 'N, ' num2str(app.EditField_R_lat_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_latcamber,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_latcamber,'lateral wheel force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_latcamber.YAxis.FontSize=10;
        app.UIAxesLeft_R_latcamber.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_latcamber,'Lateral Camber Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_latcamber,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_latcamber); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_latcamber, x_ticks);

        set(app.UIAxesLeft_R_latcamber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_latcamber_left = legend(app.UIAxesLeft_R_latcamber,'show');
        set(legend_R_latcamber_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(Lat_camber_cf_left(1,1),6))  '*x+' num2str(round(Lat_camber_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_latcamber);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_latcamber);
        text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_latcamber);

        hold(app.UIAxesLeft_R_latcamber,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_latcamber,'on');

        plot(app.UIAxesRight_R_latcamber,Susp_static_load_data(:,14),Susp_static_load_data(:,4),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_latcamber,Susp_static_load_data(Row_No_p1:Row_No_p2,14),Lat_camber_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,14)+Lat_camber_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_lat_rangeshow.Value) 'N, ' num2str(app.EditField_R_lat_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_latcamber,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_latcamber,'lateral force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_latcamber.YAxis.FontSize=10;
        app.UIAxesRight_R_latcamber.XAxis.FontSize=10;

        title(app.UIAxesRight_R_latcamber,'Lateral Camber Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_latcamber,'on');

        xticks(app.UIAxesRight_R_latcamber, x_ticks);

        set(app.UIAxesRight_R_latcamber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend(app.UIAxesRight_R_latcamber,'show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(Lat_camber_cf_right(1,1),6))  '*x+' num2str(round(Lat_camber_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_latcamber);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_latcamber);
        text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_latcamber);


        hold(app.UIAxesRight_R_latcamber,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % lat compliance change
        %------------------------------------------------------------------------------------------------------------------------

        app.latcompEditField.Value =1000*(round(Lat_WC_cf_left(1,1),6)+round(Lat_WC_cf_right(1,1),6))/2;

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_latcomp,'on');

        plot(app.UIAxesLeft_R_latcomp,Susp_static_load_data(:,13),Susp_static_load_data(:,7),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_latcomp,Susp_static_load_data(Row_No_p1:Row_No_p2,13),Lat_WC_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,13)+Lat_WC_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_lat_rangeshow.Value) 'N, ' num2str(app.EditField_R_lat_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_latcomp,'@wc Y displacement [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_latcomp,'lateral wheel force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_latcomp.YAxis.FontSize=10;
        app.UIAxesLeft_R_latcomp.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_latcomp,'Lateral Wheel Centre Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_latcomp,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_latcomp); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_latcomp, x_ticks);

        set(app.UIAxesLeft_R_latcomp,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_latcomp_left = legend(app.UIAxesLeft_R_latcomp,'show');
        set(legend_R_latcomp_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(Lat_WC_cf_left(1,1),6))  '*x+' num2str(round(Lat_WC_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_latcomp);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_latcomp);
        text(0.03, 0.5,'move to left                        move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_latcomp);

        hold(app.UIAxesLeft_R_latcomp,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_latcomp,'on');

        plot(app.UIAxesRight_R_latcomp,Susp_static_load_data(:,14),Susp_static_load_data(:,8),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_latcomp,Susp_static_load_data(Row_No_p1:Row_No_p2,14),Lat_WC_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,14)+Lat_WC_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_lat_rangeshow.Value) 'N, ' num2str(app.EditField_R_lat_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_latcomp,'@wc Y displacement [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_latcomp,'lateral force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_latcomp.YAxis.FontSize=10;
        app.UIAxesRight_R_latcomp.XAxis.FontSize=10;

        title(app.UIAxesRight_R_latcomp,'Lateral Wheel Centre Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_latcomp,'on');

        xticks(app.UIAxesRight_R_latcomp, x_ticks);

        set(app.UIAxesRight_R_latcomp,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_comp_right = legend(app.UIAxesRight_R_latcomp,'show');
        set(legend_R_comp_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(Lat_WC_cf_right(1,1),6))  '*x+' num2str(round(Lat_WC_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_latcomp);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_latcomp);
        text(0.03, 0.5,'move to left                        move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_latcomp);


        hold(app.UIAxesRight_R_latcomp,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % lat caster change
        %------------------------------------------------------------------------------------------------------------------------

        app.latspinEditField.Value =Susp_static_load_data(Row_No_p0,23);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_latspin,'on');

        plot(app.UIAxesLeft_R_latspin,Susp_static_load_data(:,13),Susp_static_load_data(:,23),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_latspin,'Kingpin Caster angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_latspin,'lateral wheel force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_latspin.YAxis.FontSize=10;
        app.UIAxesLeft_R_latspin.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_latspin,'Lat. Kingpin Caster Angle Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_latspin,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_latspin); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_latspin, x_ticks);

        set(app.UIAxesLeft_R_latspin,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_latspin_left = legend(app.UIAxesLeft_R_latspin,'show');
        set(legend_R_latspin_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Caster Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,23),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_latspin);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_latspin);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_latspin);

        hold(app.UIAxesLeft_R_latspin,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_latspin,'on');

        plot(app.UIAxesRight_R_latspin,Susp_static_load_data(:,14),Susp_static_load_data(:,24),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_latspin,'Kingpin Caster angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_latspin,'lateral force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_latspin.YAxis.FontSize=10;
        app.UIAxesRight_R_latspin.XAxis.FontSize=10;

        title(app.UIAxesRight_R_latspin,'Lat. Kingpin Caster Angle Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_latspin,'on');

        xticks(app.UIAxesRight_R_latspin, x_ticks);

        set(app.UIAxesRight_R_latspin,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_caster_right = legend(app.UIAxesRight_R_latspin,'show');
        set(legend_caster_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Caster Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,24),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_latspin);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_latspin);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_latspin);


        hold(app.UIAxesRight_R_latspin,'off');

        %------------------------------------------------------------------------------------------------------------------------
        % lat inclination change
        %------------------------------------------------------------------------------------------------------------------------

        app.latincEditField.Value =Susp_static_load_data(Row_No_p0,25);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_latinc,'on');

        plot(app.UIAxesLeft_R_latinc,Susp_static_load_data(:,13),Susp_static_load_data(:,25),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_latinc,'Kingpin inclination angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_latinc,'lateral wheel force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_latinc.YAxis.FontSize=10;
        app.UIAxesLeft_R_latinc.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_latinc,'Lat. Kingpin inclination Angle Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_latinc,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_latinc); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_latinc, x_ticks);

        set(app.UIAxesLeft_R_latinc,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_latinc_left = legend(app.UIAxesLeft_R_latinc,'show');
        set(legend_R_latinc_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin inclination Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,25),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_latinc);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_latinc);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_latinc);

        hold(app.UIAxesLeft_R_latinc,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_latinc,'on');

        plot(app.UIAxesRight_R_latinc,Susp_static_load_data(:,14),Susp_static_load_data(:,26),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_latinc,'Kingpin inclination angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_latinc,'lateral force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_latinc.YAxis.FontSize=10;
        app.UIAxesRight_R_latinc.XAxis.FontSize=10;

        title(app.UIAxesRight_R_latinc,'Lat. Kingpin inclination Angle Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_latinc,'on');

        xticks(app.UIAxesRight_R_latinc, x_ticks);

        set(app.UIAxesRight_R_latinc,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_inclination_right = legend(app.UIAxesRight_R_latinc,'show');
        set(legend_inclination_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin inclination Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,26),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_latinc);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_latinc);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_latinc);


        hold(app.UIAxesRight_R_latinc,'off');
        %------------------------------------------------------------------------------------------------------------------------
        % lat Scrub Radius change
        %------------------------------------------------------------------------------------------------------------------------

        app.latsrEditField.Value =Susp_static_load_data(Row_No_p0,27);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_latsr,'on');

        plot(app.UIAxesLeft_R_latsr,Susp_static_load_data(:,13),Susp_static_load_data(:,27),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_latsr,'Scrub Radius variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_latsr,'lateral wheel force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_latsr.YAxis.FontSize=10;
        app.UIAxesLeft_R_latsr.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_latsr,'Lat. Scrub Radius Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_latsr,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_latsr); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_latsr, x_ticks);

        set(app.UIAxesLeft_R_latsr,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_latsr_left = legend(app.UIAxesLeft_R_latsr,'show');
        set(legend_R_latsr_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Scrub Radiusat ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,27),6))  'mm'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_latsr);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_latsr);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_latsr);

        hold(app.UIAxesLeft_R_latsr,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_latsr,'on');

        plot(app.UIAxesRight_R_latsr,Susp_static_load_data(:,14),Susp_static_load_data(:,28),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_latsr,'Scrub Radius variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_latsr,'lateral force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_latsr.YAxis.FontSize=10;
        app.UIAxesRight_R_latsr.XAxis.FontSize=10;

        title(app.UIAxesRight_R_latsr,'Lat. Scrub Radius Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_latsr,'on');

        xticks(app.UIAxesRight_R_latsr, x_ticks);

        set(app.UIAxesRight_R_latsr,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_latsr_right = legend(app.UIAxesRight_R_latsr,'show');
        set(legend_R_latsr_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Scrub Radius at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,28),6))  'mm'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_latsr);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_latsr);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_latsr);


        hold(app.UIAxesRight_R_latsr,'off');
        %------------------------------------------------------------------------------------------------------------------------
        % lat caster moment arm change
        %------------------------------------------------------------------------------------------------------------------------

        app.latcmaEditField.Value =Susp_static_load_data(Row_No_p0,29);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_latcma,'on');

        plot(app.UIAxesLeft_R_latcma,Susp_static_load_data(:,13),Susp_static_load_data(:,29),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_latcma,'caster moment arm variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_latcma,'lateral wheel force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_latcma.YAxis.FontSize=10;
        app.UIAxesLeft_R_latcma.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_latcma,'Lat. Caster Moment Arm Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_latcma,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_latcma); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_latcma, x_ticks);

        set(app.UIAxesLeft_R_latcma,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_latcma_left = legend(app.UIAxesLeft_R_latcma,'show');
        set(legend_R_latcma_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Caster Moment Arm at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,29),6))  'mm'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_latcma);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_latcma);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_latcma);

        hold(app.UIAxesLeft_R_latcma,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_latcma,'on');

        plot(app.UIAxesRight_R_latcma,Susp_static_load_data(:,14),Susp_static_load_data(:,30),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_latcma,'caster moment arm variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_latcma,'lateral force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_latcma.YAxis.FontSize=10;
        app.UIAxesRight_R_latcma.XAxis.FontSize=10;

        title(app.UIAxesRight_R_latcma,'Lat. Caster Moment Arm Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_latcma,'on');

        xticks(app.UIAxesRight_R_latcma, x_ticks);

        set(app.UIAxesRight_R_latcma,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_latcma_right = legend(app.UIAxesRight_R_latcma,'show');
        set(legend_R_latcma_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Caster Moment Arm at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,30),6))  'mm'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_latcma);

        text(0.5, 0.01,'load to right                        load to left','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_latcma);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_latcma);


        hold(app.UIAxesRight_R_latcma,'off');




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
        hold(app.UIAxesLeft_R_brakingtoe,'on');

        plot(app.UIAxesLeft_R_brakingtoe,Susp_static_load_data(:,15),Susp_static_load_data(:,1),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_brakingtoe,Susp_static_load_data(Row_No_p1:Row_No_p2,15),braking_toe_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,15)+braking_toe_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_braking_rangeshow.Value) 'N, ' num2str(app.EditField_R_braking_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_brakingtoe,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_brakingtoe,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_brakingtoe.YAxis.FontSize=10;
        app.UIAxesLeft_R_brakingtoe.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_brakingtoe,'Braking Toe Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_brakingtoe,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakingtoe); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_brakingtoe, x_ticks);

        set(app.UIAxesLeft_R_brakingtoe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingtoe_left = legend(app.UIAxesLeft_R_brakingtoe,'show');
        set(legend_R_brakingtoe_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(braking_toe_cf_left(1,1),6))  '*x+' num2str(round(braking_toe_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_brakingtoe);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_brakingtoe);
        text(0.03, 0.5,'toe out                                      toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_brakingtoe);

        hold(app.UIAxesLeft_R_brakingtoe,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_brakingtoe,'on');

        plot(app.UIAxesRight_R_brakingtoe,Susp_static_load_data(:,16),Susp_static_load_data(:,2),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_brakingtoe,Susp_static_load_data(Row_No_p1:Row_No_p2,16),braking_toe_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,16)+braking_toe_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_braking_rangeshow.Value) 'N, ' num2str(app.EditField_R_braking_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_brakingtoe,'toe angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_brakingtoe,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_brakingtoe.YAxis.FontSize=10;
        app.UIAxesRight_R_brakingtoe.XAxis.FontSize=10;

        title(app.UIAxesRight_R_brakingtoe,'Braking Toe Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_brakingtoe,'on');

        xticks(app.UIAxesRight_R_brakingtoe, x_ticks);

        set(app.UIAxesRight_R_brakingtoe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend(app.UIAxesRight_R_brakingtoe,'show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(braking_toe_cf_right(1,1),6))  '*x+' num2str(round(braking_toe_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_brakingtoe);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_brakingtoe);
        text(0.03, 0.5,'toe out                                      toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_brakingtoe);


        hold(app.UIAxesRight_R_brakingtoe,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % braking camber change
        %------------------------------------------------------------------------------------------------------------------------

        app.brakingcamberEditField.Value =1000*(round(braking_camber_cf_left(1,1),6)+round(braking_camber_cf_right(1,1),6))/2;

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_brakingcamber,'on');

        plot(app.UIAxesLeft_R_brakingcamber,Susp_static_load_data(:,15),Susp_static_load_data(:,3),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_brakingcamber,Susp_static_load_data(Row_No_p1:Row_No_p2,15),braking_camber_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,15)+braking_camber_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_braking_rangeshow.Value) 'N, ' num2str(app.EditField_R_braking_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_brakingcamber,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_brakingcamber,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_brakingcamber.YAxis.FontSize=10;
        app.UIAxesLeft_R_brakingcamber.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_brakingcamber,'Braking Camber Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_brakingcamber,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakingcamber); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_brakingcamber, x_ticks);

        set(app.UIAxesLeft_R_brakingcamber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingcamber_left = legend(app.UIAxesLeft_R_brakingcamber,'show');
        set(legend_R_brakingcamber_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(braking_camber_cf_left(1,1),6))  '*x+' num2str(round(braking_camber_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_brakingcamber);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_brakingcamber);
        text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_brakingcamber);

        hold(app.UIAxesLeft_R_brakingcamber,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_brakingcamber,'on');

        plot(app.UIAxesRight_R_brakingcamber,Susp_static_load_data(:,16),Susp_static_load_data(:,4),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_brakingcamber,Susp_static_load_data(Row_No_p1:Row_No_p2,16),braking_camber_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,16)+braking_camber_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_braking_rangeshow.Value) 'N, ' num2str(app.EditField_R_braking_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_brakingcamber,'camber angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_brakingcamber,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_brakingcamber.YAxis.FontSize=10;
        app.UIAxesRight_R_brakingcamber.XAxis.FontSize=10;

        title(app.UIAxesRight_R_brakingcamber,'Braking Camber Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_brakingcamber,'on');

        xticks(app.UIAxesRight_R_brakingcamber, x_ticks);

        set(app.UIAxesRight_R_brakingcamber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend(app.UIAxesRight_R_brakingcamber,'show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(braking_camber_cf_right(1,1),6))  '*x+' num2str(round(braking_camber_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_brakingcamber);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_brakingcamber);
        text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_brakingcamber);


        hold(app.UIAxesRight_R_brakingcamber,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % braking antidive change
        %------------------------------------------------------------------------------------------------------------------------

        app.brakingantidiveEditField.Value =double(rad2deg(atan(braking_antidive_cf_left(1,1))));

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_brakingantidive,'on');

        plot(app.UIAxesLeft_R_brakingantidive,Susp_static_load_data(:,15),Susp_static_load_data(:,31),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);

        ylabel(app.UIAxesLeft_R_brakingantidive,'left tire force [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_brakingantidive,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_brakingantidive.YAxis.FontSize=10;
        app.UIAxesLeft_R_brakingantidive.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_brakingantidive,'Braking anti-dive/lift Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_brakingantidive,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakingantidive); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_brakingantidive, x_ticks);

        set(app.UIAxesLeft_R_brakingantidive,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingantidive_left = legend(app.UIAxesLeft_R_brakingantidive,'show');
        set(legend_R_brakingantidive_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['Anti-dive =' num2str(round(-1*rad2deg(atan(braking_antidive_cf_left(1,1))),2)) '° (for rear susp. tire force decreased is positiv)'  ],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_brakingantidive);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_brakingantidive);
        %text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_brakingantidive);

        hold(app.UIAxesLeft_R_brakingantidive,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_brakingantidive,'on');

        plot(app.UIAxesRight_R_brakingantidive,Susp_static_load_data(:,16),Susp_static_load_data(:,32),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_brakingantidive,'right tire force [N]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_brakingantidive,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_brakingantidive.YAxis.FontSize=10;
        app.UIAxesRight_R_brakingantidive.XAxis.FontSize=10;

        title(app.UIAxesRight_R_brakingantidive,'Braking anti-dive/lift Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_brakingantidive,'on');

        xticks(app.UIAxesRight_R_brakingantidive, x_ticks);

        set(app.UIAxesRight_R_brakingantidive,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend(app.UIAxesRight_R_brakingantidive,'show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Anti-dive =' num2str(round(-1*rad2deg(atan(braking_antidive_cf_right(1,1))),2)) '° (for rear susp. tire force decreased is positiv)'  ],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_brakingantidive);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_brakingantidive);
        %text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_brakingantidive);


        hold(app.UIAxesRight_R_brakingantidive,'off');

        %------------------------------------------------------------------------------------------------------------------------
        % braking compliance change
        %------------------------------------------------------------------------------------------------------------------------

        app.brakingcompEditField.Value =1000*(round(braking_WC_cf_left(1,1),6)+round(braking_WC_cf_right(1,1),6))/2;

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_brakingcomp,'on');

        plot(app.UIAxesLeft_R_brakingcomp,Susp_static_load_data(:,15),Susp_static_load_data(:,5),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_brakingcomp,Susp_static_load_data(Row_No_p1:Row_No_p2,15),braking_WC_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,15)+braking_WC_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_braking_rangeshow.Value) 'N, ' num2str(app.EditField_R_braking_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_brakingcomp,'@wc X displacement [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_brakingcomp,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_brakingcomp.YAxis.FontSize=10;
        app.UIAxesLeft_R_brakingcomp.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_brakingcomp,'Braking Wheel Centre Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_brakingcomp,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakingcomp); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_brakingcomp, x_ticks);

        set(app.UIAxesLeft_R_brakingcomp,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingcomp_left = legend(app.UIAxesLeft_R_brakingcomp,'show');
        set(legend_R_brakingcomp_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(braking_WC_cf_left(1,1),6))  '*x+' num2str(round(braking_WC_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_brakingcomp);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_brakingcomp);
        text(0.03, 0.5,'move to front                        move to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesLeft_R_brakingcomp);

        hold(app.UIAxesLeft_R_brakingcomp,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_brakingcomp,'on');

        plot(app.UIAxesRight_R_brakingcomp,Susp_static_load_data(:,16),Susp_static_load_data(:,6),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_brakingcomp,Susp_static_load_data(Row_No_p1:Row_No_p2,16),braking_WC_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,16)+braking_WC_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_braking_rangeshow.Value) 'N, ' num2str(app.EditField_R_braking_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_brakingcomp,'@wc X displacement [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_brakingcomp,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_brakingcomp.YAxis.FontSize=10;
        app.UIAxesRight_R_brakingcomp.XAxis.FontSize=10;

        title(app.UIAxesRight_R_brakingcomp,'Braking Wheel Centre Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_brakingcomp,'on');

        xticks(app.UIAxesRight_R_brakingcomp, x_ticks);

        set(app.UIAxesRight_R_brakingcomp,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_comp_right = legend(app.UIAxesRight_R_brakingcomp,'show');
        set(legend_R_comp_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(braking_WC_cf_right(1,1),6))  '*x+' num2str(round(braking_WC_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_brakingcomp);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_brakingcomp);
        text(0.03, 0.5,'move to front                        move to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Rotation',90,'Parent',app.UIAxesRight_R_brakingcomp);


        hold(app.UIAxesRight_R_brakingcomp,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % braking caster change
        %------------------------------------------------------------------------------------------------------------------------

        app.brakingspinEditField.Value =Susp_static_load_data(Row_No_p0,23);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_brakingspin,'on');

        plot(app.UIAxesLeft_R_brakingspin,Susp_static_load_data(:,15),Susp_static_load_data(:,23),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_brakingspin,'Kingpin Caster angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_brakingspin,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_brakingspin.YAxis.FontSize=10;
        app.UIAxesLeft_R_brakingspin.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_brakingspin,'braking. Kingpin Caster Angle Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_brakingspin,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakingspin); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_brakingspin, x_ticks);

        set(app.UIAxesLeft_R_brakingspin,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingspin_left = legend(app.UIAxesLeft_R_brakingspin,'show');
        set(legend_R_brakingspin_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Caster Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,23),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_brakingspin);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_brakingspin);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_brakingspin);

        hold(app.UIAxesLeft_R_brakingspin,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_brakingspin,'on');

        plot(app.UIAxesRight_R_brakingspin,Susp_static_load_data(:,16),Susp_static_load_data(:,24),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_brakingspin,'Kingpin Caster angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_brakingspin,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_brakingspin.YAxis.FontSize=10;
        app.UIAxesRight_R_brakingspin.XAxis.FontSize=10;

        title(app.UIAxesRight_R_brakingspin,'braking. Kingpin Caster Angle Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_brakingspin,'on');

        xticks(app.UIAxesRight_R_brakingspin, x_ticks);

        set(app.UIAxesRight_R_brakingspin,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_caster_right = legend(app.UIAxesRight_R_brakingspin,'show');
        set(legend_caster_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Caster Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,24),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_brakingspin);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_brakingspin);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_brakingspin);


        hold(app.UIAxesRight_R_brakingspin,'off');

        %------------------------------------------------------------------------------------------------------------------------
        % braking inclination change
        %------------------------------------------------------------------------------------------------------------------------

        app.brakingincEditField.Value =Susp_static_load_data(Row_No_p0,25);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_brakinginc,'on');

        plot(app.UIAxesLeft_R_brakinginc,Susp_static_load_data(:,15),Susp_static_load_data(:,25),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_brakinginc,'Kingpin inclination angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_brakinginc,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_brakinginc.YAxis.FontSize=10;
        app.UIAxesLeft_R_brakinginc.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_brakinginc,'braking. Kingpin inclination Angle Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_brakinginc,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakinginc); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_brakinginc, x_ticks);

        set(app.UIAxesLeft_R_brakinginc,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakinginc_left = legend(app.UIAxesLeft_R_brakinginc,'show');
        set(legend_R_brakinginc_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin inclination Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,25),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_brakinginc);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_brakinginc);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_brakinginc);

        hold(app.UIAxesLeft_R_brakinginc,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_brakinginc,'on');

        plot(app.UIAxesRight_R_brakinginc,Susp_static_load_data(:,16),Susp_static_load_data(:,26),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_brakinginc,'Kingpin inclination angle variation [°]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_brakinginc,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_brakinginc.YAxis.FontSize=10;
        app.UIAxesRight_R_brakinginc.XAxis.FontSize=10;

        title(app.UIAxesRight_R_brakinginc,'braking. Kingpin inclination Angle Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_brakinginc,'on');

        xticks(app.UIAxesRight_R_brakinginc, x_ticks);

        set(app.UIAxesRight_R_brakinginc,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_inclination_right = legend(app.UIAxesRight_R_brakinginc,'show');
        set(legend_inclination_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin inclination Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,26),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_brakinginc);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_brakinginc);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_brakinginc);


        hold(app.UIAxesRight_R_brakinginc,'off');
        %------------------------------------------------------------------------------------------------------------------------
        % braking Scrub Radius change
        %------------------------------------------------------------------------------------------------------------------------

        app.brakingsrEditField.Value =Susp_static_load_data(Row_No_p0,27);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_brakingsr,'on');

        plot(app.UIAxesLeft_R_brakingsr,Susp_static_load_data(:,15),Susp_static_load_data(:,27),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_brakingsr,'Scrub Radius variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_brakingsr,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_brakingsr.YAxis.FontSize=10;
        app.UIAxesLeft_R_brakingsr.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_brakingsr,'braking. Scrub Radius Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_brakingsr,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakingsr); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_brakingsr, x_ticks);

        set(app.UIAxesLeft_R_brakingsr,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingsr_left = legend(app.UIAxesLeft_R_brakingsr,'show');
        set(legend_R_brakingsr_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Scrub Radius at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,27),6))  'mm'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_brakingsr);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_brakingsr);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_brakingsr);

        hold(app.UIAxesLeft_R_brakingsr,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_brakingsr,'on');

        plot(app.UIAxesRight_R_brakingsr,Susp_static_load_data(:,16),Susp_static_load_data(:,28),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_brakingsr,'Scrub Radius variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_brakingsr,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_brakingsr.YAxis.FontSize=10;
        app.UIAxesRight_R_brakingsr.XAxis.FontSize=10;

        title(app.UIAxesRight_R_brakingsr,'braking. Scrub Radius Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_brakingsr,'on');

        xticks(app.UIAxesRight_R_brakingsr, x_ticks);

        set(app.UIAxesRight_R_brakingsr,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingsr_right = legend(app.UIAxesRight_R_brakingsr,'show');
        set(legend_R_brakingsr_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Scrub Radius at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,28),6))  'mm'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_brakingsr);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_brakingsr);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_brakingsr);


        hold(app.UIAxesRight_R_brakingsr,'off');
        %------------------------------------------------------------------------------------------------------------------------
        % braking caster moment arm change
        %------------------------------------------------------------------------------------------------------------------------

        app.brakingcmaEditField.Value =Susp_static_load_data(Row_No_p0,29);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_brakingcma,'on');

        plot(app.UIAxesLeft_R_brakingcma,Susp_static_load_data(:,15),Susp_static_load_data(:,29),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_brakingcma,'caster moment arm variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesLeft_R_brakingcma,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesLeft_R_brakingcma.YAxis.FontSize=10;
        app.UIAxesLeft_R_brakingcma.XAxis.FontSize=10;

        title(app.UIAxesLeft_R_brakingcma,'braking. Caster Moment Arm Left','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesLeft_R_brakingcma,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_brakingcma); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_brakingcma, x_ticks);

        set(app.UIAxesLeft_R_brakingcma,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingcma_left = legend(app.UIAxesLeft_R_brakingcma,'show');
        set(legend_R_brakingcma_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Caster Moment Arm at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,29),6))  'mm'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesLeft_R_brakingcma);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesLeft_R_brakingcma);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_brakingcma);

        hold(app.UIAxesLeft_R_brakingcma,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_brakingcma,'on');

        plot(app.UIAxesRight_R_brakingcma,Susp_static_load_data(:,16),Susp_static_load_data(:,30),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_brakingcma,'caster moment arm variation [mm]','HorizontalAlignment','center', 'FontWeight', 'bold');
        xlabel(app.UIAxesRight_R_brakingcma,'longitudinal wheel force - braking [N]','HorizontalAlignment','center', 'FontWeight', 'bold');

        app.UIAxesRight_R_brakingcma.YAxis.FontSize=10;
        app.UIAxesRight_R_brakingcma.XAxis.FontSize=10;

        title(app.UIAxesRight_R_brakingcma,'braking. Caster Moment Arm Right','HorizontalAlignment','center','FontWeight','bold','FontSize',10);

        box(app.UIAxesRight_R_brakingcma,'on');

        xticks(app.UIAxesRight_R_brakingcma, x_ticks);

        set(app.UIAxesRight_R_brakingcma,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_brakingcma_right = legend(app.UIAxesRight_R_brakingcma,'show');
        set(legend_R_brakingcma_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Caster Moment Arm at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,30),6))  'mm'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',10,'FontName','Times New Roman','Parent',app.UIAxesRight_R_brakingcma);

        text(0.5, 0.01,'load to front                        load to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',10,'FontName','Times New Roman', 'FontWeight', 'bold','Parent',app.UIAxesRight_R_brakingcma);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_brakingcma);


        hold(app.UIAxesRight_R_brakingcma,'off');


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


        %------------------------------------------------------------------------------------------------------------------------
        % accel toe change
        %------------------------------------------------------------------------------------------------------------------------

        app.acceltoeEditField.Value =1000*(round(accel_toe_cf_left(1,1),2)+round(accel_toe_cf_right(1,1),2))/2;


        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_acceltoe,'on');

        plot(app.UIAxesLeft_R_acceltoe,Susp_static_load_data(:,17),Susp_static_load_data(:,1),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_acceltoe,Susp_static_load_data(Row_No_p1:Row_No_p2,17),accel_toe_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,17)+accel_toe_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_accel_rangeshow.Value) 'N, ' num2str(app.EditField_R_accel_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_acceltoe,'toe angle variation [°]','HorizontalAlignment','center');
        xlabel(app.UIAxesLeft_R_acceltoe,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesLeft_R_acceltoe.YAxis.FontSize=12;
        app.UIAxesLeft_R_acceltoe.XAxis.FontSize=12;

        title(app.UIAxesLeft_R_acceltoe,'accel Toe Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesLeft_R_acceltoe,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_acceltoe); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_acceltoe, x_ticks);

        set(app.UIAxesLeft_R_acceltoe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_acceltoe_left = legend(app.UIAxesLeft_R_acceltoe,'show');
        set(legend_R_acceltoe_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(accel_toe_cf_left(1,1),6))  '*x+' num2str(round(accel_toe_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesLeft_R_acceltoe);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesLeft_R_acceltoe);
        text(0.03, 0.5,'toe out                                      toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_acceltoe);

        hold(app.UIAxesLeft_R_acceltoe,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_acceltoe,'on');

        plot(app.UIAxesRight_R_acceltoe,Susp_static_load_data(:,18),Susp_static_load_data(:,2),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_acceltoe,Susp_static_load_data(Row_No_p1:Row_No_p2,18),accel_toe_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,18)+accel_toe_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_accel_rangeshow.Value) 'N, ' num2str(app.EditField_R_accel_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_acceltoe,'toe angle variation [°]','HorizontalAlignment','center');
        xlabel(app.UIAxesRight_R_acceltoe,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesRight_R_acceltoe.YAxis.FontSize=12;
        app.UIAxesRight_R_acceltoe.XAxis.FontSize=12;

        title(app.UIAxesRight_R_acceltoe,'accel Toe Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesRight_R_acceltoe,'on');

        xticks(app.UIAxesRight_R_acceltoe, x_ticks);

        set(app.UIAxesRight_R_acceltoe,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend(app.UIAxesRight_R_acceltoe,'show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(accel_toe_cf_right(1,1),6))  '*x+' num2str(round(accel_toe_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesRight_R_acceltoe);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesRight_R_acceltoe);
        text(0.03, 0.5,'toe out                                      toe in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_acceltoe);


        hold(app.UIAxesRight_R_acceltoe,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % accel camber change
        %------------------------------------------------------------------------------------------------------------------------

        app.accelcamberEditField.Value =1000*(round(accel_camber_cf_left(1,1),2)+round(accel_camber_cf_right(1,1),2))/2;

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_accelcamber,'on');

        plot(app.UIAxesLeft_R_accelcamber,Susp_static_load_data(:,17),Susp_static_load_data(:,3),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_accelcamber,Susp_static_load_data(Row_No_p1:Row_No_p2,17),accel_camber_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,17)+accel_camber_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_accel_rangeshow.Value) 'N, ' num2str(app.EditField_R_accel_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_accelcamber,'camber angle variation [°]','HorizontalAlignment','center');
        xlabel(app.UIAxesLeft_R_accelcamber,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesLeft_R_accelcamber.YAxis.FontSize=12;
        app.UIAxesLeft_R_accelcamber.XAxis.FontSize=12;

        title(app.UIAxesLeft_R_accelcamber,'accel Camber Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesLeft_R_accelcamber,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_accelcamber); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_accelcamber, x_ticks);

        set(app.UIAxesLeft_R_accelcamber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelcamber_left = legend(app.UIAxesLeft_R_accelcamber,'show');
        set(legend_R_accelcamber_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(accel_camber_cf_left(1,1),6))  '*x+' num2str(round(accel_camber_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesLeft_R_accelcamber);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesLeft_R_accelcamber);
        text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_accelcamber);

        hold(app.UIAxesLeft_R_accelcamber,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_accelcamber,'on');

        plot(app.UIAxesRight_R_accelcamber,Susp_static_load_data(:,18),Susp_static_load_data(:,4),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_accelcamber,Susp_static_load_data(Row_No_p1:Row_No_p2,18),accel_camber_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,18)+accel_camber_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_accel_rangeshow.Value) 'N, ' num2str(app.EditField_R_accel_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_accelcamber,'camber angle variation [°]','HorizontalAlignment','center');
        xlabel(app.UIAxesRight_R_accelcamber,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesRight_R_accelcamber.YAxis.FontSize=12;
        app.UIAxesRight_R_accelcamber.XAxis.FontSize=12;

        title(app.UIAxesRight_R_accelcamber,'accel Camber Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesRight_R_accelcamber,'on');

        xticks(app.UIAxesRight_R_accelcamber, x_ticks);

        set(app.UIAxesRight_R_accelcamber,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend(app.UIAxesRight_R_accelcamber,'show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(accel_camber_cf_right(1,1),6))  '*x+' num2str(round(accel_camber_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesRight_R_accelcamber);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesRight_R_accelcamber);
        text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_accelcamber);


        hold(app.UIAxesRight_R_accelcamber,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % accel antidive change
        %------------------------------------------------------------------------------------------------------------------------

        app.accelantidiveEditField.Value =round(Susp_static_load_data(Row_No_p0,34),1);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_accelantidive,'on');

        plot(app.UIAxesLeft_R_accelantidive,Susp_static_load_data(:,17),Susp_static_load_data(:,33),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);

        ylabel(app.UIAxesLeft_R_accelantidive,'percent anti_squat_acceleration left [%]','HorizontalAlignment','center');
        xlabel(app.UIAxesLeft_R_accelantidive,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesLeft_R_accelantidive.YAxis.FontSize=12;
        app.UIAxesLeft_R_accelantidive.XAxis.FontSize=12;

        title(app.UIAxesLeft_R_accelantidive,'accel antidive Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesLeft_R_accelantidive,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_accelantidive); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_accelantidive, x_ticks);

        set(app.UIAxesLeft_R_accelantidive,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelantidive_left = legend(app.UIAxesLeft_R_accelantidive,'show');
        set(legend_R_accelantidive_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['Acceleration Anti-Squat =' num2str(round(Susp_static_load_data(Row_No_p0,33),1)) '%'  ],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesLeft_R_accelantidive);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesLeft_R_accelantidive);
        %text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_accelantidive);

        hold(app.UIAxesLeft_R_accelantidive,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_accelantidive,'on');

        plot(app.UIAxesRight_R_accelantidive,Susp_static_load_data(:,18),Susp_static_load_data(:,34),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_accelantidive,'percent anti_squat_acceleration right [%]','HorizontalAlignment','center');
        xlabel(app.UIAxesRight_R_accelantidive,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesRight_R_accelantidive.YAxis.FontSize=12;
        app.UIAxesRight_R_accelantidive.XAxis.FontSize=12;

        title(app.UIAxesRight_R_accelantidive,'accel antidive Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesRight_R_accelantidive,'on');

        xticks(app.UIAxesRight_R_accelantidive, x_ticks);

        set(app.UIAxesRight_R_accelantidive,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_toe_right = legend(app.UIAxesRight_R_accelantidive,'show');
        set(legend_toe_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Acceleration Anti-Squat =' num2str(round(Susp_static_load_data(Row_No_p0,34),1)) '%'  ],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesRight_R_accelantidive);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesRight_R_accelantidive);
        %text(0.03, 0.5,'top in                                      top out','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_accelantidive);


        hold(app.UIAxesRight_R_accelantidive,'off');

        %------------------------------------------------------------------------------------------------------------------------
        % accel compliance change
        %------------------------------------------------------------------------------------------------------------------------

        app.accelcompEditField.Value =1000*(round(accel_WC_cf_left(1,1),2)+round(accel_WC_cf_right(1,1),2))/2;

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_accelcomp,'on');

        plot(app.UIAxesLeft_R_accelcomp,Susp_static_load_data(:,17),Susp_static_load_data(:,5),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesLeft_R_accelcomp,Susp_static_load_data(Row_No_p1:Row_No_p2,17),accel_WC_cf_left(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,17)+accel_WC_cf_left(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_accel_rangeshow.Value) 'N, ' num2str(app.EditField_R_accel_rangeshow.Value) 'N]'],'MarkerIndices',[1,((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12);

        ylabel(app.UIAxesLeft_R_accelcomp,'@wc X displacement [mm]','HorizontalAlignment','center');
        xlabel(app.UIAxesLeft_R_accelcomp,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesLeft_R_accelcomp.YAxis.FontSize=12;
        app.UIAxesLeft_R_accelcomp.XAxis.FontSize=12;

        title(app.UIAxesLeft_R_accelcomp,'accel Wheel Centre Compliance Left','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesLeft_R_accelcomp,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_accelcomp); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_accelcomp, x_ticks);

        set(app.UIAxesLeft_R_accelcomp,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelcomp_left = legend(app.UIAxesLeft_R_accelcomp,'show');
        set(legend_R_accelcomp_left,'Location','best');

        text(0.5, 0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(accel_WC_cf_left(1,1),6))  '*x+' num2str(round(accel_WC_cf_left(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesLeft_R_accelcomp);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesLeft_R_accelcomp);
        text(0.03, 0.5,'move to front                        move to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_accelcomp);

        hold(app.UIAxesLeft_R_accelcomp,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_accelcomp,'on');

        plot(app.UIAxesRight_R_accelcomp,Susp_static_load_data(:,18),Susp_static_load_data(:,6),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);
        plot(app.UIAxesRight_R_accelcomp,Susp_static_load_data(Row_No_p1:Row_No_p2,18),accel_WC_cf_right(1,1)*Susp_static_load_data(Row_No_p1:Row_No_p2,18)+accel_WC_cf_right(1,2),...
            'DisplayName',['curve fitting [' num2str(-app.EditField_R_accel_rangeshow.Value) 'N, ' num2str(app.EditField_R_accel_rangeshow.Value) 'N]'],'MarkerIndices',[1 ((Row_No_p2-Row_No_p1)+1)],'Marker','o','Color',app.ColorPicker_fit.Value,'MarkerSize', 12)

        ylabel(app.UIAxesRight_R_accelcomp,'@wc X displacement [mm]','HorizontalAlignment','center');
        xlabel(app.UIAxesRight_R_accelcomp,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesRight_R_accelcomp.YAxis.FontSize=12;
        app.UIAxesRight_R_accelcomp.XAxis.FontSize=12;

        title(app.UIAxesRight_R_accelcomp,'accel Wheel Centre Compliance Right','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesRight_R_accelcomp,'on');

        xticks(app.UIAxesRight_R_accelcomp, x_ticks);

        set(app.UIAxesRight_R_accelcomp,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_comp_right = legend(app.UIAxesRight_R_accelcomp,'show');
        set(legend_R_comp_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['y =' num2str(round(accel_WC_cf_right(1,1),6))  '*x+' num2str(round(accel_WC_cf_right(1,2),4))],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesRight_R_accelcomp);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesRight_R_accelcomp);
        text(0.03, 0.5,'move to front                        move to rear','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_accelcomp);


        hold(app.UIAxesRight_R_accelcomp,'off');


        %------------------------------------------------------------------------------------------------------------------------
        % accel caster change
        %------------------------------------------------------------------------------------------------------------------------

        app.accelspinEditField.Value =Susp_static_load_data(Row_No_p0,23);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_accelspin,'on');

        plot(app.UIAxesLeft_R_accelspin,Susp_static_load_data(:,17),Susp_static_load_data(:,23),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_accelspin,'Kingpin Caster angle variation [°]','HorizontalAlignment','center');
        xlabel(app.UIAxesLeft_R_accelspin,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesLeft_R_accelspin.YAxis.FontSize=12;
        app.UIAxesLeft_R_accelspin.XAxis.FontSize=12;

        title(app.UIAxesLeft_R_accelspin,'accel. Kingpin Caster Angle Left','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesLeft_R_accelspin,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_accelspin); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_accelspin, x_ticks);

        set(app.UIAxesLeft_R_accelspin,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelspin_left = legend(app.UIAxesLeft_R_accelspin,'show');
        set(legend_R_accelspin_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Caster Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,23),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesLeft_R_accelspin);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesLeft_R_accelspin);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_accelspin);

        hold(app.UIAxesLeft_R_accelspin,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_accelspin,'on');

        plot(app.UIAxesRight_R_accelspin,Susp_static_load_data(:,18),Susp_static_load_data(:,24),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_accelspin,'Kingpin Caster angle variation [°]','HorizontalAlignment','center');
        xlabel(app.UIAxesRight_R_accelspin,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesRight_R_accelspin.YAxis.FontSize=12;
        app.UIAxesRight_R_accelspin.XAxis.FontSize=12;

        title(app.UIAxesRight_R_accelspin,'accel. Kingpin Caster Angle Right','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesRight_R_accelspin,'on');

        xticks(app.UIAxesRight_R_accelspin, x_ticks);

        set(app.UIAxesRight_R_accelspin,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_caster_right = legend(app.UIAxesRight_R_accelspin,'show');
        set(legend_caster_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Caster Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,24),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesRight_R_accelspin);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesRight_R_accelspin);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_accelspin);


        hold(app.UIAxesRight_R_accelspin,'off');

        %------------------------------------------------------------------------------------------------------------------------
        % accel inclination change
        %------------------------------------------------------------------------------------------------------------------------

        app.accelincEditField.Value =Susp_static_load_data(Row_No_p0,25);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_accelinc,'on');

        plot(app.UIAxesLeft_R_accelinc,Susp_static_load_data(:,17),Susp_static_load_data(:,25),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_accelinc,'Kingpin inclination angle variation [°]','HorizontalAlignment','center');
        xlabel(app.UIAxesLeft_R_accelinc,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesLeft_R_accelinc.YAxis.FontSize=12;
        app.UIAxesLeft_R_accelinc.XAxis.FontSize=12;

        title(app.UIAxesLeft_R_accelinc,'accel. Kingpin inclination Angle Left','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesLeft_R_accelinc,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_accelinc); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_accelinc, x_ticks);

        set(app.UIAxesLeft_R_accelinc,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelinc_left = legend(app.UIAxesLeft_R_accelinc,'show');
        set(legend_R_accelinc_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin inclination Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,25),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesLeft_R_accelinc);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesLeft_R_accelinc);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_accelinc);

        hold(app.UIAxesLeft_R_accelinc,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_accelinc,'on');

        plot(app.UIAxesRight_R_accelinc,Susp_static_load_data(:,18),Susp_static_load_data(:,26),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_accelinc,'Kingpin inclination angle variation [°]','HorizontalAlignment','center');
        xlabel(app.UIAxesRight_R_accelinc,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesRight_R_accelinc.YAxis.FontSize=12;
        app.UIAxesRight_R_accelinc.XAxis.FontSize=12;

        title(app.UIAxesRight_R_accelinc,'accel. Kingpin inclination Angle Right','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesRight_R_accelinc,'on');

        xticks(app.UIAxesRight_R_accelinc, x_ticks);

        set(app.UIAxesRight_R_accelinc,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_inclination_right = legend(app.UIAxesRight_R_accelinc,'show');
        set(legend_inclination_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin inclination Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,26),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesRight_R_accelinc);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesRight_R_accelinc);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_accelinc);


        hold(app.UIAxesRight_R_accelinc,'off');
        %------------------------------------------------------------------------------------------------------------------------
        % accel Scrub Radius change
        %------------------------------------------------------------------------------------------------------------------------

        app.accelsrEditField.Value =Susp_static_load_data(Row_No_p0,27);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_accelsr,'on');

        plot(app.UIAxesLeft_R_accelsr,Susp_static_load_data(:,17),Susp_static_load_data(:,27),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_accelsr,'Scrub Radius variation [mm]','HorizontalAlignment','center');
        xlabel(app.UIAxesLeft_R_accelsr,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesLeft_R_accelsr.YAxis.FontSize=12;
        app.UIAxesLeft_R_accelsr.XAxis.FontSize=12;

        title(app.UIAxesLeft_R_accelsr,'accel. Scrub Radius Left','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesLeft_R_accelsr,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_accelsr); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_accelsr, x_ticks);

        set(app.UIAxesLeft_R_accelsr,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelsr_left = legend(app.UIAxesLeft_R_accelsr,'show');
        set(legend_R_accelsr_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Scrub Radius Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,27),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesLeft_R_accelsr);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesLeft_R_accelsr);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_accelsr);

        hold(app.UIAxesLeft_R_accelsr,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_accelsr,'on');

        plot(app.UIAxesRight_R_accelsr,Susp_static_load_data(:,18),Susp_static_load_data(:,28),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_accelsr,'Scrub Radius variation [mm]','HorizontalAlignment','center');
        xlabel(app.UIAxesRight_R_accelsr,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesRight_R_accelsr.YAxis.FontSize=12;
        app.UIAxesRight_R_accelsr.XAxis.FontSize=12;

        title(app.UIAxesRight_R_accelsr,'accel. Scrub Radius Right','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesRight_R_accelsr,'on');

        xticks(app.UIAxesRight_R_accelsr, x_ticks);

        set(app.UIAxesRight_R_accelsr,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelsr_right = legend(app.UIAxesRight_R_accelsr,'show');
        set(legend_R_accelsr_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Scrub Radius Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,28),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesRight_R_accelsr);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesRight_R_accelsr);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_accelsr);


        hold(app.UIAxesRight_R_accelsr,'off');
        %------------------------------------------------------------------------------------------------------------------------
        % accel caster moment arm change
        %------------------------------------------------------------------------------------------------------------------------

        app.accelcmaEditField.Value =Susp_static_load_data(Row_No_p0,29);

        %left---------------------------------------------------
        hold(app.UIAxesLeft_R_accelcma,'on');

        plot(app.UIAxesLeft_R_accelcma,Susp_static_load_data(:,17),Susp_static_load_data(:,29),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesLeft_R_accelcma,'caster moment arm variation [mm]','HorizontalAlignment','center');
        xlabel(app.UIAxesLeft_R_accelcma,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesLeft_R_accelcma.YAxis.FontSize=12;
        app.UIAxesLeft_R_accelcma.XAxis.FontSize=12;

        title(app.UIAxesLeft_R_accelcma,'accel. Caster Moment Arm Left','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesLeft_R_accelcma,'on');

        % 获取 x 轴的范围
        xlim_values = xlim(app.UIAxesLeft_R_accelcma); min_x = xlim_values(1); max_x = xlim_values(2);
        % 创建一个以 2000 为间隔的刻度位置数组
        x_ticks = min_x:2000:max_x;
        % 设置 x 轴刻度位置
        xticks(app.UIAxesLeft_R_accelcma, x_ticks);

        set(app.UIAxesLeft_R_accelcma,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelcma_left = legend(app.UIAxesLeft_R_accelcma,'show');
        set(legend_R_accelcma_left,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Scrub Radius Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,29),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesLeft_R_accelcma);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesLeft_R_accelcma);
        %text(0.03, 0.5,'top out                                      top in','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesLeft_R_accelcma);

        hold(app.UIAxesLeft_R_accelcma,'off');

        %right---------------------------------------------------
        hold(app.UIAxesRight_R_accelcma,'on');

        plot(app.UIAxesRight_R_accelcma,Susp_static_load_data(:,18),Susp_static_load_data(:,30),'DisplayName','Result','Color',app.ColorPicker_curve.Value,'LineWidth', 1.5);


        ylabel(app.UIAxesRight_R_accelcma,'caster moment arm variation [mm]','HorizontalAlignment','center');
        xlabel(app.UIAxesRight_R_accelcma,'longitudinal wheel force - acceleration [N]','HorizontalAlignment','center');

        app.UIAxesRight_R_accelcma.YAxis.FontSize=12;
        app.UIAxesRight_R_accelcma.XAxis.FontSize=12;

        title(app.UIAxesRight_R_accelcma,'accel. Caster Moment Arm Right','HorizontalAlignment','center','FontWeight','bold','FontSize',12);

        box(app.UIAxesRight_R_accelcma,'on');

        xticks(app.UIAxesRight_R_accelcma, x_ticks);

        set(app.UIAxesRight_R_accelcma,'XGrid','on','XMinorTick','on','YGrid','on','YMinorTick','on');

        legend_R_accelcma_right = legend(app.UIAxesRight_R_accelcma,'show');
        set(legend_R_accelcma_right,'Location','best');

        text(0.5,0.6+0.1*app.toCompareSpinner.Value,['Kingpin Scrub Radius Angle at ZERO = ' num2str(round(Susp_static_load_data(Row_No_p0,30),6))  '°'],'Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color',app.ColorPicker_fit.Value,'FontSize',14,'Parent',app.UIAxesRight_R_accelcma);

        text(0.5, 0.01,'load to rear                        load to front','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom','FontSize',11,'Parent',app.UIAxesRight_R_accelcma);
        %text(0.03, 0.5,'move to left                                  move to right','Units', 'normalized','HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','FontSize',11,'Rotation',90,'Parent',app.UIAxesRight_R_accelcma);


        hold(app.UIAxesRight_R_accelcma,'off');






    end
end