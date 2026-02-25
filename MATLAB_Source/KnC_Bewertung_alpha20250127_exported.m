classdef KnC_Bewertung_alpha20250127_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        beta0304012025Label             matlab.ui.control.Label
        Image                           matlab.ui.control.Image
        Label_KineBench                 matlab.ui.control.Label
        TabGroup_vehicle                matlab.ui.container.TabGroup
        Tab_vehicle_parameter           matlab.ui.container.Tab
        GridLayout2                     matlab.ui.container.GridLayout
        ExampleDolphinLabel             matlab.ui.control.Label
        mmLabel_7                       matlab.ui.control.Label
        mmLabel_6                       matlab.ui.control.Label
        mmLabel_5                       matlab.ui.control.Label
        KgLabel_7                       matlab.ui.control.Label
        Label_3                         matlab.ui.control.Label
        KgLabel_6                       matlab.ui.control.Label
        KgLabel_5                       matlab.ui.control.Label
        KgLabel_4                       matlab.ui.control.Label
        mmLabel_4                       matlab.ui.control.Label
        RollAngleEditField_2            matlab.ui.control.NumericEditField
        RollAngleEditField_2Label       matlab.ui.control.Label
        TireEditField_2                 matlab.ui.control.NumericEditField
        TireEditField_2Label            matlab.ui.control.Label
        UnsprungEditField_2             matlab.ui.control.NumericEditField
        UnsprungEditField_2Label        matlab.ui.control.Label
        MaxLoadEditField_2              matlab.ui.control.NumericEditField
        MaxLoadEditField_2Label         matlab.ui.control.Label
        HalfLoadEditField_3             matlab.ui.control.NumericEditField
        HalfLoadEditField_3Label        matlab.ui.control.Label
        TrackFrontEditField             matlab.ui.control.NumericEditField
        TrackFrontEditFieldLabel        matlab.ui.control.Label
        VehicleLabel                    matlab.ui.control.Label
        Label_2                         matlab.ui.control.Label
        KgLabel_3                       matlab.ui.control.Label
        KgLabel_2                       matlab.ui.control.Label
        KgLabel                         matlab.ui.control.Label
        mmLabel_3                       matlab.ui.control.Label
        RearSuspLabel                   matlab.ui.control.Label
        TireEditField                   matlab.ui.control.EditField
        TireEditFieldLabel              matlab.ui.control.Label
        TrackRearEditField              matlab.ui.control.NumericEditField
        TrackRearEditFieldLabel         matlab.ui.control.Label
        FrontSuspLabel                  matlab.ui.control.Label
        COGHeightEditField              matlab.ui.control.NumericEditField
        COGHeightEditFieldLabel         matlab.ui.control.Label
        COGinxEditField                 matlab.ui.control.NumericEditField
        COGinxEditFieldLabel            matlab.ui.control.Label
        HalfLoadEditField_2             matlab.ui.control.NumericEditField
        HalfLoadEditField_2Label        matlab.ui.control.Label
        RollAngleEditField              matlab.ui.control.NumericEditField
        RollAngleLabel                  matlab.ui.control.Label
        WheelBaseEditField              matlab.ui.control.NumericEditField
        WheelBaseLabel                  matlab.ui.control.Label
        UnsprungEditField               matlab.ui.control.NumericEditField
        UnsprungLabel                   matlab.ui.control.Label
        MaxLoadEditField                matlab.ui.control.NumericEditField
        MaxLoadLabel                    matlab.ui.control.Label
        HalfLoadEditField               matlab.ui.control.NumericEditField
        HalfLoadLabel                   matlab.ui.control.Label
        ToolsTab                        matlab.ui.container.Tab
        EditField                       matlab.ui.control.NumericEditField
        EditFieldLabel                  matlab.ui.control.Label
        TabGroup_KC_bench               matlab.ui.container.TabGroup
        Tab_KC_rear                     matlab.ui.container.Tab
        AllKnCfinishedthenoutputChassisSynthesisToolButton  matlab.ui.control.Button
        ResetButton                     matlab.ui.control.Button
        toCompareSpinner                matlab.ui.control.Spinner
        toCompareSpinnerLabel           matlab.ui.control.Label
        FittingLabel                    matlab.ui.control.Label
        CurveLabel                      matlab.ui.control.Label
        ColorPicker_fit                 matlab.ui.control.ColorPicker
        ColorPicker_curve               matlab.ui.control.ColorPicker
        AddResultsButton                matlab.ui.control.Button
        SaveResultsinEXCELButton        matlab.ui.control.Button
        SaveResultsinPPTButton          matlab.ui.control.Button
        Tab_KcRear                      matlab.ui.container.TabGroup
        STARTINFOTab                    matlab.ui.container.Tab
        GridLayout5                     matlab.ui.container.GridLayout
        UpdateDocLabel                  matlab.ui.control.Label
        GridLayout6                     matlab.ui.container.GridLayout
        ReadMEPanel                     matlab.ui.container.Panel
        ListBox                         matlab.ui.control.ListBox
        Image32                         matlab.ui.control.Image
        TextArea_25                     matlab.ui.control.TextArea
        Tab_KcRear_Bump                 matlab.ui.container.Tab
        Button_2                        matlab.ui.control.Button
        Button                          matlab.ui.control.Button
        VWUPButton                      matlab.ui.control.StateButton
        VWGolfButton_2                  matlab.ui.control.StateButton
        TwistBeamLabel                  matlab.ui.control.Label
        ABDSPMMPlusLabel_3              matlab.ui.control.Label
        BYDDolphinButton                matlab.ui.control.StateButton
        TOYOTAYarisButton               matlab.ui.control.StateButton
        BMW325iButton                   matlab.ui.control.StateButton
        VWID3Button                     matlab.ui.control.StateButton
        TestReportLabel                 matlab.ui.control.Label
        ABDSPMMPlusLabel_2              matlab.ui.control.Label
        TestBenchResultsLabel           matlab.ui.control.Label
        ABDSPMMPlusLabel                matlab.ui.control.Label
        RefVehicleLabel                 matlab.ui.control.Label
        FORDEDGEButton                  matlab.ui.control.StateButton
        TeslaModel3Button               matlab.ui.control.StateButton
        VWPassatButton                  matlab.ui.control.StateButton
        BYDDelphinButton                matlab.ui.control.StateButton
        Button_browser_bump             matlab.ui.control.Button
        EditField_browser_bump          matlab.ui.control.EditField
        GOButton_bump                   matlab.ui.control.Button
        ResultsPanel_R_bump             matlab.ui.container.Panel
        GridLayout4                     matlab.ui.container.GridLayout
        SVSALengthEditField             matlab.ui.control.NumericEditField
        SVSALengthEditFieldLabel        matlab.ui.control.Label
        WheelRate2gHLEditField          matlab.ui.control.NumericEditField
        WheelRate2gHLEditFieldLabel     matlab.ui.control.Label
        ToeCha50mmEditField_2           matlab.ui.control.NumericEditField
        ToeCha50mmLabel                 matlab.ui.control.Label
        SuspensionFreqEditField         matlab.ui.control.NumericEditField
        SuspensionFreqEditFieldLabel    matlab.ui.control.Label
        TrackChangeEditField            matlab.ui.control.NumericEditField
        TrackChangeEditFieldLabel       matlab.ui.control.Label
        BumpCamberEditField             matlab.ui.control.NumericEditField
        BumpCamberEditFieldLabel        matlab.ui.control.Label
        WheelRateSlopeWCEditField       matlab.ui.control.NumericEditField
        WheelRateSlopeWCEditFieldLabel  matlab.ui.control.Label
        SVSAAngleEditField              matlab.ui.control.NumericEditField
        SVSAAngleEditFieldLabel         matlab.ui.control.Label
        WheelTravel2gHLEditField        matlab.ui.control.NumericEditField
        WheelTravel2gHLEditFieldLabel   matlab.ui.control.Label
        ToeCha50mmEditField             matlab.ui.control.NumericEditField
        ToeCha50mmEditFieldLabel        matlab.ui.control.Label
        SpringAngleEditField            matlab.ui.control.NumericEditField
        SpringAngleEditFieldLabel       matlab.ui.control.Label
        WheelRecessionEditField         matlab.ui.control.NumericEditField
        WheelRecessionEditFieldLabel    matlab.ui.control.Label
        BumpSteerEditField              matlab.ui.control.NumericEditField
        BumpSteerEditFieldLabel         matlab.ui.control.Label
        WheelRateWCEditField            matlab.ui.control.NumericEditField
        WheelRateWCEditFieldLabel       matlab.ui.control.Label
        PositivDirectionButton          matlab.ui.control.Button
        BumpClearAxesButton             matlab.ui.control.Button
        mmLabel_2                       matlab.ui.control.Label
        NmmLabel_13                     matlab.ui.control.Label
        degLabel_3                      matlab.ui.control.Label
        mmLabel                         matlab.ui.control.Label
        degLabel                        matlab.ui.control.Label
        degLabel_4                      matlab.ui.control.Label
        degLabel_2                      matlab.ui.control.Label
        HzLabel                         matlab.ui.control.Label
        mmmLabel_2                      matlab.ui.control.Label
        degmLabel_2                     matlab.ui.control.Label
        mmmLabel                        matlab.ui.control.Label
        degmLabel                       matlab.ui.control.Label
        NmmmmLabel                      matlab.ui.control.Label
        NmmLabel                        matlab.ui.control.Label
        TabGroup_R_bump_results         matlab.ui.container.TabGroup
        WheelRateWCTab                  matlab.ui.container.Tab
        GridLayout_7                    matlab.ui.container.GridLayout
        Image_kc_02_bump                matlab.ui.control.Image
        Image_kc_01_bump                matlab.ui.control.Image
        InfoPanel_8                     matlab.ui.container.Panel
        Image9_41                       matlab.ui.control.Image
        Image2_48                       matlab.ui.control.Image
        DatePicker_41                   matlab.ui.control.DatePicker
        CreatorDropDown_8               matlab.ui.control.DropDown
        CreatorDropDown_8Label          matlab.ui.control.Label
        FlexbodySwitch_8                matlab.ui.control.Switch
        VersionEditField_8              matlab.ui.control.EditField
        VersionEditField_8Label         matlab.ui.control.Label
        ProjectEditField_8              matlab.ui.control.EditField
        ProjectEditField_8Label         matlab.ui.control.Label
        DatePicker_8                    matlab.ui.control.DatePicker
        ResultEvaluationPanel_7         matlab.ui.container.Panel
        TextArea_7                      matlab.ui.control.TextArea
        Lamp_7                          matlab.ui.control.Lamp
        BewertungDropDown_7             matlab.ui.control.DropDown
        UIAxesRight_wheelload           matlab.ui.control.UIAxes
        UIAxesLeft_wheelload            matlab.ui.control.UIAxes
        WheelRateSlopeWCTab             matlab.ui.container.Tab
        GridLayout_8                    matlab.ui.container.GridLayout
        InfoPanel_2                     matlab.ui.container.Panel
        Image9_7                        matlab.ui.control.Image
        Image2_14                       matlab.ui.control.Image
        CreatorDropDown_2               matlab.ui.control.DropDown
        CreatorDropDown_2Label          matlab.ui.control.Label
        FlexbodySwitch_2                matlab.ui.control.Switch
        VersionEditField_2              matlab.ui.control.EditField
        VersionEditField_2Label         matlab.ui.control.Label
        ProjectEditField_2              matlab.ui.control.EditField
        ProjectEditField_2Label         matlab.ui.control.Label
        DatePicker_2                    matlab.ui.control.DatePicker
        ResultEvaluationPanel_8         matlab.ui.container.Panel
        TextArea_8                      matlab.ui.control.TextArea
        Lamp_8                          matlab.ui.control.Lamp
        BewertungDropDown_8             matlab.ui.control.DropDown
        UIAxesRight_R_B_Wheelrate       matlab.ui.control.UIAxes
        UIAxesLeft_R_B_Wheelrate        matlab.ui.control.UIAxes
        BumpSteerTab                    matlab.ui.container.Tab
        GridLayout                      matlab.ui.container.GridLayout
        ResultEvaluationPanel           matlab.ui.container.Panel
        TextArea                        matlab.ui.control.TextArea
        Lamp                            matlab.ui.control.Lamp
        BewertungDropDown               matlab.ui.control.DropDown
        InfoPanel                       matlab.ui.container.Panel
        Image9_6                        matlab.ui.control.Image
        Image2_13                       matlab.ui.control.Image
        CreatorDropDown                 matlab.ui.control.DropDown
        CreatorDropDownLabel            matlab.ui.control.Label
        FlexbodySwitch                  matlab.ui.control.Switch
        VersionEditField                matlab.ui.control.EditField
        VersionLabel                    matlab.ui.control.Label
        ProjectEditField                matlab.ui.control.EditField
        ProjectEditFieldLabel           matlab.ui.control.Label
        DatePicker                      matlab.ui.control.DatePicker
        UIAxesRight_R_B_toe             matlab.ui.control.UIAxes
        UIAxesLeft_R_B_toe              matlab.ui.control.UIAxes
        BumperCamberTab                 matlab.ui.container.Tab
        GridLayout_2                    matlab.ui.container.GridLayout
        InfoPanel_3                     matlab.ui.container.Panel
        Image9_5                        matlab.ui.control.Image
        Image2_12                       matlab.ui.control.Image
        CreatorDropDown_3               matlab.ui.control.DropDown
        CreatorDropDown_3Label          matlab.ui.control.Label
        FlexbodySwitch_3                matlab.ui.control.Switch
        VersionEditField_3              matlab.ui.control.EditField
        VersionEditField_3Label         matlab.ui.control.Label
        ProjectEditField_3              matlab.ui.control.EditField
        ProjectEditField_3Label         matlab.ui.control.Label
        DatePicker_3                    matlab.ui.control.DatePicker
        ResultEvaluationPanel_2         matlab.ui.container.Panel
        TextArea_2                      matlab.ui.control.TextArea
        Lamp_2                          matlab.ui.control.Lamp
        BewertungDropDown_2             matlab.ui.control.DropDown
        UIAxesRight_R_B_camber          matlab.ui.control.UIAxes
        UIAxesLeft_R_B_camber           matlab.ui.control.UIAxes
        WheelRecessionTab               matlab.ui.container.Tab
        GridLayout_3                    matlab.ui.container.GridLayout
        InfoPanel_4                     matlab.ui.container.Panel
        Image9_4                        matlab.ui.control.Image
        Image2_11                       matlab.ui.control.Image
        CreatorDropDown_4               matlab.ui.control.DropDown
        CreatorDropDown_4Label          matlab.ui.control.Label
        FlexbodySwitch_4                matlab.ui.control.Switch
        VersionEditField_4              matlab.ui.control.EditField
        VersionEditField_4Label         matlab.ui.control.Label
        ProjectEditField_4              matlab.ui.control.EditField
        ProjectEditField_4Label         matlab.ui.control.Label
        DatePicker_4                    matlab.ui.control.DatePicker
        ResultEvaluationPanel_3         matlab.ui.container.Panel
        TextArea_3                      matlab.ui.control.TextArea
        Lamp_3                          matlab.ui.control.Lamp
        BewertungDropDown_3             matlab.ui.control.DropDown
        UIAxesRight_R_B_WB              matlab.ui.control.UIAxes
        UIAxesLeft_R_B_WB               matlab.ui.control.UIAxes
        TrackChangeTab                  matlab.ui.container.Tab
        GridLayout_4                    matlab.ui.container.GridLayout
        InfoPanel_5                     matlab.ui.container.Panel
        Image9_3                        matlab.ui.control.Image
        Image2_10                       matlab.ui.control.Image
        CreatorDropDown_5               matlab.ui.control.DropDown
        CreatorDropDown_5Label          matlab.ui.control.Label
        FlexbodySwitch_5                matlab.ui.control.Switch
        VersionEditField_5              matlab.ui.control.EditField
        VersionEditField_5Label         matlab.ui.control.Label
        ProjectEditField_5              matlab.ui.control.EditField
        ProjectEditField_5Label         matlab.ui.control.Label
        DatePicker_5                    matlab.ui.control.DatePicker
        ResultEvaluationPanel_4         matlab.ui.container.Panel
        TextArea_4                      matlab.ui.control.TextArea
        Lamp_4                          matlab.ui.control.Lamp
        BewertungDropDown_4             matlab.ui.control.DropDown
        UIAxesRight_Track               matlab.ui.control.UIAxes
        UIAxesLeft_Track                matlab.ui.control.UIAxes
        CastorAngleTab                  matlab.ui.container.Tab
        GridLayout_41                   matlab.ui.container.GridLayout
        InfoPanel_41                    matlab.ui.container.Panel
        Image9_42                       matlab.ui.control.Image
        CreatorDropDown_41              matlab.ui.control.DropDown
        CreatorDropDown_41Label         matlab.ui.control.Label
        Image2_49                       matlab.ui.control.Image
        FlexbodySwitch_41               matlab.ui.control.Switch
        VersionEditField_41             matlab.ui.control.EditField
        VersionEditField_41Label        matlab.ui.control.Label
        ProjectEditField_42             matlab.ui.control.EditField
        ProjectEditField_42Label        matlab.ui.control.Label
        DatePicker_42                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_41        matlab.ui.container.Panel
        TextArea_42                     matlab.ui.control.TextArea
        Lamp_41                         matlab.ui.control.Lamp
        BewertungDropDown_41            matlab.ui.control.DropDown
        UIAxesLeft_Castor               matlab.ui.control.UIAxes
        UIAxesRight_Castor              matlab.ui.control.UIAxes
        SVSAAngleTab                    matlab.ui.container.Tab
        GridLayout_5                    matlab.ui.container.GridLayout
        InfoPanel_6                     matlab.ui.container.Panel
        Image9_2                        matlab.ui.control.Image
        Image2_9                        matlab.ui.control.Image
        CreatorDropDown_6               matlab.ui.control.DropDown
        CreatorDropDown_6Label          matlab.ui.control.Label
        FlexbodySwitch_6                matlab.ui.control.Switch
        VersionEditField_6              matlab.ui.control.EditField
        VersionEditField_6Label         matlab.ui.control.Label
        ProjectEditField_6              matlab.ui.control.EditField
        ProjectEditField_6Label         matlab.ui.control.Label
        DatePicker_6                    matlab.ui.control.DatePicker
        ResultEvaluationPanel_5         matlab.ui.container.Panel
        TextArea_5                      matlab.ui.control.TextArea
        Lamp_5                          matlab.ui.control.Lamp
        BewertungDropDown_5             matlab.ui.control.DropDown
        UIAxesRight_swa                 matlab.ui.control.UIAxes
        UIAxesLeft_swa                  matlab.ui.control.UIAxes
        SVSALengthTab                   matlab.ui.container.Tab
        GridLayout_6                    matlab.ui.container.GridLayout
        InfoPanel_7                     matlab.ui.container.Panel
        Image9                          matlab.ui.control.Image
        CreatorDropDown_7               matlab.ui.control.DropDown
        CreatorDropDown_7Label          matlab.ui.control.Label
        Image2_7                        matlab.ui.control.Image
        FlexbodySwitch_7                matlab.ui.control.Switch
        VersionEditField_7              matlab.ui.control.EditField
        VersionEditField_7Label         matlab.ui.control.Label
        ProjectEditField_7              matlab.ui.control.EditField
        ProjectEditField_7Label         matlab.ui.control.Label
        DatePicker_7                    matlab.ui.control.DatePicker
        ResultEvaluationPanel_6         matlab.ui.container.Panel
        TextArea_6                      matlab.ui.control.TextArea
        Lamp_6                          matlab.ui.control.Lamp
        BewertungDropDown_6             matlab.ui.control.DropDown
        UIAxesRight_swl                 matlab.ui.control.UIAxes
        UIAxesLeft_swl                  matlab.ui.control.UIAxes
        mmLabel_bump_rangshow           matlab.ui.control.Label
        EditField_R_bump_range          matlab.ui.control.NumericEditField
        FittingRangeKnob                matlab.ui.control.DiscreteKnob
        FittingRangeLabel               matlab.ui.control.Label
        CurrentFileLabel_2              matlab.ui.control.Label
        Tab_KcRear_Roll                 matlab.ui.container.Tab
        Button_4                        matlab.ui.control.Button
        Button_3                        matlab.ui.control.Button
        VWUPButton_2                    matlab.ui.control.StateButton
        VWGolfButton_3                  matlab.ui.control.StateButton
        TwistBeamLabel_2                matlab.ui.control.Label
        ABDSPMMPlusLabel_6              matlab.ui.control.Label
        BYDDolphinButton_2              matlab.ui.control.StateButton
        TOYOTAYarisButton_2             matlab.ui.control.StateButton
        BMW325iButton_2                 matlab.ui.control.StateButton
        VWID3Button_2                   matlab.ui.control.StateButton
        TestReportLabel_2               matlab.ui.control.Label
        ABDSPMMPlusLabel_5              matlab.ui.control.Label
        TestBenchResultsLabel_2         matlab.ui.control.Label
        ABDSPMMPlusLabel_4              matlab.ui.control.Label
        RefVehicleLabel_7               matlab.ui.control.Label
        FORDEDGEButton_7                matlab.ui.control.StateButton
        TeslaModel3Button_7             matlab.ui.control.StateButton
        VWPassatButton_7                matlab.ui.control.StateButton
        BYDDelphinButton_7              matlab.ui.control.StateButton
        FittingRangeKnob_2Label         matlab.ui.control.Label
        Button_browser_R_roll           matlab.ui.control.Button
        EditField_browser_R_roll        matlab.ui.control.EditField
        GOButton_R_roll                 matlab.ui.control.Button
        ResultsPanel_R_roll             matlab.ui.container.Panel
        GridLayout3                     matlab.ui.container.GridLayout
        NRACTargetLabel                 matlab.ui.control.Label
        PositivDirectionButton_2        matlab.ui.control.Button
        RollClearAxesButton             matlab.ui.control.Button
        mmLabel_9                       matlab.ui.control.Label
        mmLabel_8                       matlab.ui.control.Label
        mLabel_2                        matlab.ui.control.Label
        mLabel                          matlab.ui.control.Label
        ABDLabel                        matlab.ui.control.Label
        MTSLabel                        matlab.ui.control.Label
        Label_4                         matlab.ui.control.Label
        NmLabel                         matlab.ui.control.Label
        RollRCHchangeEditField          matlab.ui.control.NumericEditField
        RCHChangeEditFieldLabel         matlab.ui.control.Label
        RollRCHEditField                matlab.ui.control.NumericEditField
        KinRollCenterHeightEditFieldLabel  matlab.ui.control.Label
        RollCamberWTEditField           matlab.ui.control.NumericEditField
        OutofPhaseCamberEditFieldLabel  matlab.ui.control.Label
        RollSteerWTEditField            matlab.ui.control.NumericEditField
        OutofPhaseSteerEditFieldLabel   matlab.ui.control.Label
        RollCamberGroundEditField       matlab.ui.control.NumericEditField
        CamberRelGroundEditFieldLabel   matlab.ui.control.Label
        RollCamberEditField             matlab.ui.control.NumericEditField
        RollCamberEditFieldLabel        matlab.ui.control.Label
        RollSteerEditField              matlab.ui.control.NumericEditField
        ToeChangeWCEditFieldLabel       matlab.ui.control.Label
        R_rollrateEditField             matlab.ui.control.NumericEditField
        RollRateWCEditFieldLabel        matlab.ui.control.Label
        tbdLabel_7                      matlab.ui.control.Label
        tbdLabel_6                      matlab.ui.control.Label
        tbdLabel_5                      matlab.ui.control.Label
        tbdLabel_4                      matlab.ui.control.Label
        tbdLabel_3                      matlab.ui.control.Label
        tbdLabel_2                      matlab.ui.control.Label
        tbdLabel                        matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        TabGroup_R_roll_results         matlab.ui.container.TabGroup
        RollRateWCTab                   matlab.ui.container.Tab
        GridLayout_9                    matlab.ui.container.GridLayout
        InfoPanel_9                     matlab.ui.container.Panel
        RollTestLabel_2                 matlab.ui.control.Label
        Image9_9                        matlab.ui.control.Image
        Image2_16                       matlab.ui.control.Image
        CreatorDropDown_9               matlab.ui.control.DropDown
        CreatorDropDown_9Label          matlab.ui.control.Label
        FlexbodySwitch_9                matlab.ui.control.Switch
        VersionEditField_9              matlab.ui.control.EditField
        VersionEditField_9Label         matlab.ui.control.Label
        ProjectEditField_9              matlab.ui.control.EditField
        ProjectEditField_9Label         matlab.ui.control.Label
        DatePicker_9                    matlab.ui.control.DatePicker
        ResultEvaluationPanel_9         matlab.ui.container.Panel
        TextArea_9                      matlab.ui.control.TextArea
        Lamp_9                          matlab.ui.control.Lamp
        BewertungDropDown_9             matlab.ui.control.DropDown
        UIAxesRight_R_R_Rollrate        matlab.ui.control.UIAxes
        UIAxesLeft_R_R_Rollrate         matlab.ui.control.UIAxes
        RollSteerTab                    matlab.ui.container.Tab
        GridLayout_11                   matlab.ui.container.GridLayout
        ResultEvaluationPanel_11        matlab.ui.container.Panel
        TextArea_11                     matlab.ui.control.TextArea
        Lamp_11                         matlab.ui.control.Lamp
        BewertungDropDown_11            matlab.ui.control.DropDown
        InfoPanel_11                    matlab.ui.container.Panel
        RollTestLabel                   matlab.ui.control.Label
        Image9_11                       matlab.ui.control.Image
        Image2_18                       matlab.ui.control.Image
        CreatorDropDown_11              matlab.ui.control.DropDown
        CreatorDropDown_11Label         matlab.ui.control.Label
        FlexbodySwitch_11               matlab.ui.control.Switch
        VersionEditField_11             matlab.ui.control.EditField
        VersionEditField_11Label        matlab.ui.control.Label
        ProjectEditField_11             matlab.ui.control.EditField
        ProjectEditField_11Label        matlab.ui.control.Label
        DatePicker_11                   matlab.ui.control.DatePicker
        UIAxesRight_R_R_toe             matlab.ui.control.UIAxes
        UIAxesLeft_R_R_toe              matlab.ui.control.UIAxes
        RollCamberTab                   matlab.ui.container.Tab
        GridLayout_12                   matlab.ui.container.GridLayout
        InfoPanel_12                    matlab.ui.container.Panel
        RollTestLabel_3                 matlab.ui.control.Label
        Image9_12                       matlab.ui.control.Image
        Image2_19                       matlab.ui.control.Image
        CreatorDropDown_12              matlab.ui.control.DropDown
        CreatorDropDown_12Label         matlab.ui.control.Label
        FlexbodySwitch_12               matlab.ui.control.Switch
        VersionEditField_12             matlab.ui.control.EditField
        VersionEditField_12Label        matlab.ui.control.Label
        ProjectEditField_12             matlab.ui.control.EditField
        ProjectEditField_12Label        matlab.ui.control.Label
        DatePicker_12                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_12        matlab.ui.container.Panel
        TextArea_12                     matlab.ui.control.TextArea
        Lamp_12                         matlab.ui.control.Lamp
        BewertungDropDown_12            matlab.ui.control.DropDown
        UIAxesRight_R_R_camber          matlab.ui.control.UIAxes
        UIAxesLeft_R_R_camber           matlab.ui.control.UIAxes
        RollCamberrelGroundTab          matlab.ui.container.Tab
        GridLayout_13                   matlab.ui.container.GridLayout
        InfoPanel_13                    matlab.ui.container.Panel
        RollTestLabel_4                 matlab.ui.control.Label
        Image9_13                       matlab.ui.control.Image
        Image2_20                       matlab.ui.control.Image
        CreatorDropDown_13              matlab.ui.control.DropDown
        CreatorDropDown_13Label         matlab.ui.control.Label
        FlexbodySwitch_13               matlab.ui.control.Switch
        VersionEditField_13             matlab.ui.control.EditField
        VersionEditField_13Label        matlab.ui.control.Label
        ProjectEditField_13             matlab.ui.control.EditField
        ProjectEditField_13Label        matlab.ui.control.Label
        DatePicker_13                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_13        matlab.ui.container.Panel
        TextArea_13                     matlab.ui.control.TextArea
        Lamp_13                         matlab.ui.control.Lamp
        BewertungDropDown_13            matlab.ui.control.DropDown
        UIAxesRight_R_R_camber_ground   matlab.ui.control.UIAxes
        UIAxesLeft_R_R_camber_ground    matlab.ui.control.UIAxes
        OoPBumpSteerTab                 matlab.ui.container.Tab
        GridLayout_14                   matlab.ui.container.GridLayout
        InfoPanel_14                    matlab.ui.container.Panel
        RollTestLabel_5                 matlab.ui.control.Label
        Image9_14                       matlab.ui.control.Image
        Image2_21                       matlab.ui.control.Image
        CreatorDropDown_14              matlab.ui.control.DropDown
        CreatorDropDown_14Label         matlab.ui.control.Label
        FlexbodySwitch_14               matlab.ui.control.Switch
        VersionEditField_14             matlab.ui.control.EditField
        VersionEditField_14Label        matlab.ui.control.Label
        ProjectEditField_14             matlab.ui.control.EditField
        ProjectEditField_14Label        matlab.ui.control.Label
        DatePicker_14                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_14        matlab.ui.container.Panel
        TextArea_14                     matlab.ui.control.TextArea
        Lamp_14                         matlab.ui.control.Lamp
        BewertungDropDown_14            matlab.ui.control.DropDown
        UIAxesRight_R_R_toe_WT          matlab.ui.control.UIAxes
        UIAxesLeft_R_R_toe_WT           matlab.ui.control.UIAxes
        OoPBumpCamberTab                matlab.ui.container.Tab
        GridLayout_15                   matlab.ui.container.GridLayout
        InfoPanel_15                    matlab.ui.container.Panel
        RollTestLabel_6                 matlab.ui.control.Label
        Image9_15                       matlab.ui.control.Image
        Image2_22                       matlab.ui.control.Image
        CreatorDropDown_15              matlab.ui.control.DropDown
        CreatorDropDown_15Label         matlab.ui.control.Label
        FlexbodySwitch_15               matlab.ui.control.Switch
        VersionEditField_15             matlab.ui.control.EditField
        VersionEditField_15Label        matlab.ui.control.Label
        ProjectEditField_15             matlab.ui.control.EditField
        ProjectEditField_15Label        matlab.ui.control.Label
        DatePicker_15                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_15        matlab.ui.container.Panel
        TextArea_15                     matlab.ui.control.TextArea
        Lamp_15                         matlab.ui.control.Lamp
        BewertungDropDown_15            matlab.ui.control.DropDown
        UIAxesRight_R_R_camber_WT       matlab.ui.control.UIAxes
        UIAxesLeft_R_R_camber_WT        matlab.ui.control.UIAxes
        KinRollCenterHeightTab          matlab.ui.container.Tab
        GridLayout_16                   matlab.ui.container.GridLayout
        InfoPanel_16                    matlab.ui.container.Panel
        RollTestLabel_7                 matlab.ui.control.Label
        Image9_16                       matlab.ui.control.Image
        CreatorDropDown_16              matlab.ui.control.DropDown
        CreatorDropDown_16Label         matlab.ui.control.Label
        Image2_23                       matlab.ui.control.Image
        FlexbodySwitch_16               matlab.ui.control.Switch
        VersionEditField_16             matlab.ui.control.EditField
        VersionEditField_16Label        matlab.ui.control.Label
        ProjectEditField_16             matlab.ui.control.EditField
        ProjectEditField_16Label        matlab.ui.control.Label
        DatePicker_16                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_16        matlab.ui.container.Panel
        TextArea_16                     matlab.ui.control.TextArea
        Lamp_16                         matlab.ui.control.Lamp
        BewertungDropDown_16            matlab.ui.control.DropDown
        UIAxesRight_R_R_rch             matlab.ui.control.UIAxes
        UIAxesLeft_R_R_rch              matlab.ui.control.UIAxes
        mmLabel_R_roll_rangshow         matlab.ui.control.Label
        EditField_R_roll_range          matlab.ui.control.NumericEditField
        FittingRangeKnob_R_roll         matlab.ui.control.DiscreteKnob
        CurrentFileLabel                matlab.ui.control.Label
        Tab_KcRear_LateralForce         matlab.ui.container.Tab
        Button_6                        matlab.ui.control.Button
        Button_5                        matlab.ui.control.Button
        VWUPButton_3                    matlab.ui.control.StateButton
        VWGolfButton_4                  matlab.ui.control.StateButton
        TwistBeamLabel_3                matlab.ui.control.Label
        ABDSPMMPlusLabel_9              matlab.ui.control.Label
        BYDDolphinButton_3              matlab.ui.control.StateButton
        TOYOTAYarisButton_3             matlab.ui.control.StateButton
        BMW325iButton_3                 matlab.ui.control.StateButton
        VWID3Button_3                   matlab.ui.control.StateButton
        TestReportLabel_3               matlab.ui.control.Label
        ABDSPMMPlusLabel_8              matlab.ui.control.Label
        TestBenchResultsLabel_3         matlab.ui.control.Label
        ABDSPMMPlusLabel_7              matlab.ui.control.Label
        RefVehicleLabel_8               matlab.ui.control.Label
        FORDEDGEButton_8                matlab.ui.control.StateButton
        TeslaModel3Button_8             matlab.ui.control.StateButton
        VWPassatButton_8                matlab.ui.control.StateButton
        BYDDelphinButton_8              matlab.ui.control.StateButton
        FittingRangeKnob_R_lat          matlab.ui.control.DiscreteKnob
        FittingRangeKnob_2Label_2       matlab.ui.control.Label
        EditField_browser_R_lat         matlab.ui.control.EditField
        CurrentFileLabel_3              matlab.ui.control.Label
        Button_browser_R_lat            matlab.ui.control.Button
        GOButton_R_lat                  matlab.ui.control.Button
        ResultsPanel_R_roll_2           matlab.ui.container.Panel
        GridLayout3_2                   matlab.ui.container.GridLayout
        NRACTargetLabel_2               matlab.ui.control.Label
        LatClearAxesButton              matlab.ui.control.Button
        StatisticTargetButton_3         matlab.ui.control.Button
        mmLabel_11                      matlab.ui.control.Label
        mmLabel_10                      matlab.ui.control.Label
        Label_7                         matlab.ui.control.Label
        Label_6                         matlab.ui.control.Label
        mmkNLabel                       matlab.ui.control.Label
        kNLabel_3                       matlab.ui.control.Label
        kNLabel_2                       matlab.ui.control.Label
        kNLabel                         matlab.ui.control.Label
        latcmaEditField                 matlab.ui.control.NumericEditField
        CasterMomentArmLabel            matlab.ui.control.Label
        latsrEditField                  matlab.ui.control.NumericEditField
        ScrubRadiusLabel                matlab.ui.control.Label
        latincEditField                 matlab.ui.control.NumericEditField
        KingpinInclinationAngleLabel    matlab.ui.control.Label
        latspinEditField                matlab.ui.control.NumericEditField
        KingpinCasterAngleLabel         matlab.ui.control.Label
        latcompEditField                matlab.ui.control.NumericEditField
        LatForceComplianceWCLabel       matlab.ui.control.Label
        latcamberEditField              matlab.ui.control.NumericEditField
        LatForceCamberChangeEditFieldLabel  matlab.ui.control.Label
        lattoe1000EditField             matlab.ui.control.NumericEditField
        LatForceToeChangeLabel          matlab.ui.control.Label
        lattoeEditField                 matlab.ui.control.NumericEditField
        LatForceToeChangeLabel_2        matlab.ui.control.Label
        tbdLabel_14                     matlab.ui.control.Label
        tbdLabel_13                     matlab.ui.control.Label
        tbdLabel_12                     matlab.ui.control.Label
        tbdLabel_11                     matlab.ui.control.Label
        tbdLabel_10                     matlab.ui.control.Label
        tbdLabel_9                      matlab.ui.control.Label
        tbdLabel_8                      matlab.ui.control.Label
        Label_5                         matlab.ui.control.Label
        TabGroup_R_roll_results_2       matlab.ui.container.TabGroup
        LatForceSteerTab                matlab.ui.container.Tab
        GridLayout_18                   matlab.ui.container.GridLayout
        ResultEvaluationPanel_18        matlab.ui.container.Panel
        TextArea_18                     matlab.ui.control.TextArea
        Lamp_18                         matlab.ui.control.Lamp
        BewertungDropDown_18            matlab.ui.control.DropDown
        InfoPanel_18                    matlab.ui.container.Panel
        ProjectEditField_25             matlab.ui.control.EditField
        ProjectEditField_25Label        matlab.ui.control.Label
        LateralForceTestLabel_8         matlab.ui.control.Label
        Image9_18                       matlab.ui.control.Image
        Image2_25                       matlab.ui.control.Image
        CreatorDropDown_18              matlab.ui.control.DropDown
        CreatorDropDown_18Label         matlab.ui.control.Label
        FlexbodySwitch_18               matlab.ui.control.Switch
        VersionEditField_18             matlab.ui.control.EditField
        VersionEditField_18Label        matlab.ui.control.Label
        DatePicker_18                   matlab.ui.control.DatePicker
        UIAxesRight_R_lattoe            matlab.ui.control.UIAxes
        UIAxesLeft_R_lattoe             matlab.ui.control.UIAxes
        LatForceCamberTab               matlab.ui.container.Tab
        GridLayout_19                   matlab.ui.container.GridLayout
        InfoPanel_19                    matlab.ui.container.Panel
        LateralForceTestLabel_2         matlab.ui.control.Label
        Image9_19                       matlab.ui.control.Image
        Image2_26                       matlab.ui.control.Image
        CreatorDropDown_19              matlab.ui.control.DropDown
        CreatorDropDown_19Label         matlab.ui.control.Label
        FlexbodySwitch_19               matlab.ui.control.Switch
        VersionEditField_19             matlab.ui.control.EditField
        VersionEditField_19Label        matlab.ui.control.Label
        ProjectEditField_19             matlab.ui.control.EditField
        ProjectEditField_19Label        matlab.ui.control.Label
        DatePicker_19                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_19        matlab.ui.container.Panel
        TextArea_19                     matlab.ui.control.TextArea
        Lamp_19                         matlab.ui.control.Lamp
        BewertungDropDown_19            matlab.ui.control.DropDown
        UIAxesRight_R_latcamber         matlab.ui.control.UIAxes
        UIAxesLeft_R_latcamber          matlab.ui.control.UIAxes
        LatForceComplianceWCTab         matlab.ui.container.Tab
        GridLayout_20                   matlab.ui.container.GridLayout
        InfoPanel_20                    matlab.ui.container.Panel
        LateralForceTestLabel_3         matlab.ui.control.Label
        Image9_20                       matlab.ui.control.Image
        Image2_27                       matlab.ui.control.Image
        CreatorDropDown_20              matlab.ui.control.DropDown
        CreatorDropDown_20Label         matlab.ui.control.Label
        FlexbodySwitch_20               matlab.ui.control.Switch
        VersionEditField_20             matlab.ui.control.EditField
        VersionEditField_20Label        matlab.ui.control.Label
        ProjectEditField_20             matlab.ui.control.EditField
        ProjectEditField_20Label        matlab.ui.control.Label
        DatePicker_20                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_20        matlab.ui.container.Panel
        TextArea_20                     matlab.ui.control.TextArea
        Lamp_20                         matlab.ui.control.Lamp
        BewertungDropDown_20            matlab.ui.control.DropDown
        UIAxesRight_R_latcomp           matlab.ui.control.UIAxes
        UIAxesLeft_R_latcomp            matlab.ui.control.UIAxes
        LatSpinTab                      matlab.ui.container.Tab
        GridLayout_21                   matlab.ui.container.GridLayout
        InfoPanel_21                    matlab.ui.container.Panel
        LateralForceTestLabel_7         matlab.ui.control.Label
        Image9_21                       matlab.ui.control.Image
        Image2_28                       matlab.ui.control.Image
        CreatorDropDown_21              matlab.ui.control.DropDown
        CreatorDropDown_21Label         matlab.ui.control.Label
        FlexbodySwitch_21               matlab.ui.control.Switch
        VersionEditField_21             matlab.ui.control.EditField
        VersionEditField_21Label        matlab.ui.control.Label
        ProjectEditField_21             matlab.ui.control.EditField
        ProjectEditField_21Label        matlab.ui.control.Label
        DatePicker_21                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_21        matlab.ui.container.Panel
        TextArea_21                     matlab.ui.control.TextArea
        Lamp_21                         matlab.ui.control.Lamp
        BewertungDropDown_21            matlab.ui.control.DropDown
        UIAxesRight_R_latspin           matlab.ui.control.UIAxes
        UIAxesLeft_R_latspin            matlab.ui.control.UIAxes
        LatInclinationTab               matlab.ui.container.Tab
        GridLayout_22                   matlab.ui.container.GridLayout
        InfoPanel_22                    matlab.ui.container.Panel
        LateralForceTestLabel_6         matlab.ui.control.Label
        Image9_22                       matlab.ui.control.Image
        Image2_29                       matlab.ui.control.Image
        CreatorDropDown_22              matlab.ui.control.DropDown
        CreatorDropDown_22Label         matlab.ui.control.Label
        FlexbodySwitch_22               matlab.ui.control.Switch
        VersionEditField_22             matlab.ui.control.EditField
        VersionEditField_22Label        matlab.ui.control.Label
        ProjectEditField_22             matlab.ui.control.EditField
        ProjectEditField_22Label        matlab.ui.control.Label
        DatePicker_22                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_22        matlab.ui.container.Panel
        TextArea_22                     matlab.ui.control.TextArea
        Lamp_22                         matlab.ui.control.Lamp
        BewertungDropDown_22            matlab.ui.control.DropDown
        UIAxesRight_R_latinc            matlab.ui.control.UIAxes
        UIAxesLeft_R_latinc             matlab.ui.control.UIAxes
        LatScrubTab                     matlab.ui.container.Tab
        GridLayout_23                   matlab.ui.container.GridLayout
        InfoPanel_23                    matlab.ui.container.Panel
        LateralForceTestLabel_4         matlab.ui.control.Label
        Image9_23                       matlab.ui.control.Image
        CreatorDropDown_23              matlab.ui.control.DropDown
        CreatorDropDown_23Label         matlab.ui.control.Label
        Image2_30                       matlab.ui.control.Image
        FlexbodySwitch_23               matlab.ui.control.Switch
        VersionEditField_23             matlab.ui.control.EditField
        VersionEditField_23Label        matlab.ui.control.Label
        ProjectEditField_23             matlab.ui.control.EditField
        ProjectEditField_23Label        matlab.ui.control.Label
        DatePicker_23                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_23        matlab.ui.container.Panel
        TextArea_23                     matlab.ui.control.TextArea
        Lamp_23                         matlab.ui.control.Lamp
        BewertungDropDown_23            matlab.ui.control.DropDown
        UIAxesRight_R_latsr             matlab.ui.control.UIAxes
        UIAxesLeft_R_latsr              matlab.ui.control.UIAxes
        LatCasterArmTab                 matlab.ui.container.Tab
        GridLayout_24                   matlab.ui.container.GridLayout
        InfoPanel_24                    matlab.ui.container.Panel
        LateralForceTestLabel_5         matlab.ui.control.Label
        Image9_24                       matlab.ui.control.Image
        CreatorDropDown_24              matlab.ui.control.DropDown
        CreatorDropDown_24Label         matlab.ui.control.Label
        Image2_31                       matlab.ui.control.Image
        FlexbodySwitch_24               matlab.ui.control.Switch
        VersionEditField_24             matlab.ui.control.EditField
        VersionEditField_24Label        matlab.ui.control.Label
        ProjectEditField_24             matlab.ui.control.EditField
        ProjectEditField_24Label        matlab.ui.control.Label
        DatePicker_24                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_24        matlab.ui.container.Panel
        TextArea_24                     matlab.ui.control.TextArea
        Lamp_24                         matlab.ui.control.Lamp
        BewertungDropDown_24            matlab.ui.control.DropDown
        UIAxesRight_R_latcma            matlab.ui.control.UIAxes
        UIAxesLeft_R_latcma             matlab.ui.control.UIAxes
        mmLabel_R_lat_rangshow          matlab.ui.control.Label
        EditField_R_lat_rangeshow       matlab.ui.control.NumericEditField
        Tab_KcRear_Braking              matlab.ui.container.Tab
        Button_8                        matlab.ui.control.Button
        Button_7                        matlab.ui.control.Button
        VWUPButton_4                    matlab.ui.control.StateButton
        VWGolfButton_5                  matlab.ui.control.StateButton
        TwistBeamLabel_4                matlab.ui.control.Label
        ABDSPMMPlusLabel_12             matlab.ui.control.Label
        BYDDolphinButton_4              matlab.ui.control.StateButton
        TOYOTAYarisButton_4             matlab.ui.control.StateButton
        BMW325iButton_4                 matlab.ui.control.StateButton
        VWID3Button_4                   matlab.ui.control.StateButton
        TestReportLabel_4               matlab.ui.control.Label
        ABDSPMMPlusLabel_11             matlab.ui.control.Label
        TestBenchResultsLabel_4         matlab.ui.control.Label
        ABDSPMMPlusLabel_10             matlab.ui.control.Label
        RefVehicleLabel_9               matlab.ui.control.Label
        FORDEDGEButton_9                matlab.ui.control.StateButton
        TeslaModel3Button_9             matlab.ui.control.StateButton
        VWPassatButton_9                matlab.ui.control.StateButton
        BYDDelphinButton_9              matlab.ui.control.StateButton
        FittingRangeKnob_R_braking      matlab.ui.control.DiscreteKnob
        FittingRangeKnob_2Label_3       matlab.ui.control.Label
        EditField_browser_R_braking     matlab.ui.control.EditField
        CurrentFileLabel_4              matlab.ui.control.Label
        Button_browser_R_braking        matlab.ui.control.Button
        GOButton_R_braking              matlab.ui.control.Button
        ResultsPanel_R_braking          matlab.ui.container.Panel
        GridLayout3_3                   matlab.ui.container.GridLayout
        NRACTargetLabel_3               matlab.ui.control.Label
        PositivDirectionButton_4        matlab.ui.control.Button
        BrakingClearAxesButton          matlab.ui.control.Button
        mmLabel_13                      matlab.ui.control.Label
        mmLabel_12                      matlab.ui.control.Label
        Label_10                        matlab.ui.control.Label
        Label_9                         matlab.ui.control.Label
        mmkNLabel_2                     matlab.ui.control.Label
        kNLabel_6                       matlab.ui.control.Label
        Label_11                        matlab.ui.control.Label
        kNLabel_4                       matlab.ui.control.Label
        brakingcmaEditField             matlab.ui.control.NumericEditField
        CasterMomentArmLabel_2          matlab.ui.control.Label
        brakingsrEditField              matlab.ui.control.NumericEditField
        ScrubRadiusLabel_2              matlab.ui.control.Label
        brakingincEditField             matlab.ui.control.NumericEditField
        KingpinInclinationAngleLabel_2  matlab.ui.control.Label
        brakingspinEditField            matlab.ui.control.NumericEditField
        KingpinCasterAngleLabel_2       matlab.ui.control.Label
        brakingcompEditField            matlab.ui.control.NumericEditField
        LatForceComplianceWCLabel_2     matlab.ui.control.Label
        brakingcamberEditField          matlab.ui.control.NumericEditField
        BrakeCamberChangeLabel          matlab.ui.control.Label
        brakingantidiveEditField        matlab.ui.control.NumericEditField
        LatForceToeChangeLabel_4        matlab.ui.control.Label
        brakingtoeEditField             matlab.ui.control.NumericEditField
        LatForceToeChangeLabel_3        matlab.ui.control.Label
        tbdLabel_21                     matlab.ui.control.Label
        tbdLabel_20                     matlab.ui.control.Label
        tbdLabel_19                     matlab.ui.control.Label
        tbdLabel_18                     matlab.ui.control.Label
        tbdLabel_17                     matlab.ui.control.Label
        tbdLabel_16                     matlab.ui.control.Label
        tbdLabel_15                     matlab.ui.control.Label
        Label_8                         matlab.ui.control.Label
        TabGroup_R_braking_results      matlab.ui.container.TabGroup
        brakingSteerTab                 matlab.ui.container.Tab
        GridLayout_25                   matlab.ui.container.GridLayout
        ResultEvaluationPanel_25        matlab.ui.container.Panel
        TextArea_26                     matlab.ui.control.TextArea
        Lamp_25                         matlab.ui.control.Lamp
        BewertungDropDown_25            matlab.ui.control.DropDown
        InfoPanel_25                    matlab.ui.container.Panel
        ProjectEditField_26             matlab.ui.control.EditField
        ProjectEditField_26Label        matlab.ui.control.Label
        BrakingForceTestLabel           matlab.ui.control.Label
        Image9_25                       matlab.ui.control.Image
        Image2_32                       matlab.ui.control.Image
        CreatorDropDown_25              matlab.ui.control.DropDown
        CreatorDropDown_25Label         matlab.ui.control.Label
        FlexbodySwitch_25               matlab.ui.control.Switch
        VersionEditField_25             matlab.ui.control.EditField
        VersionEditField_25Label        matlab.ui.control.Label
        DatePicker_25                   matlab.ui.control.DatePicker
        UIAxesLeft_R_brakingtoe         matlab.ui.control.UIAxes
        UIAxesRight_R_brakingtoe        matlab.ui.control.UIAxes
        brakingCamberTab                matlab.ui.container.Tab
        GridLayout_26                   matlab.ui.container.GridLayout
        InfoPanel_26                    matlab.ui.container.Panel
        BrakingForceTestLabel_2         matlab.ui.control.Label
        Image9_26                       matlab.ui.control.Image
        Image2_33                       matlab.ui.control.Image
        CreatorDropDown_26              matlab.ui.control.DropDown
        CreatorDropDown_26Label         matlab.ui.control.Label
        FlexbodySwitch_26               matlab.ui.control.Switch
        VersionEditField_26             matlab.ui.control.EditField
        VersionEditField_26Label        matlab.ui.control.Label
        ProjectEditField_27             matlab.ui.control.EditField
        ProjectEditField_27Label        matlab.ui.control.Label
        DatePicker_26                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_26        matlab.ui.container.Panel
        TextArea_27                     matlab.ui.control.TextArea
        Lamp_26                         matlab.ui.control.Lamp
        BewertungDropDown_26            matlab.ui.control.DropDown
        UIAxesLeft_R_brakingcamber      matlab.ui.control.UIAxes
        UIAxesRight_R_brakingcamber     matlab.ui.control.UIAxes
        brakingComplianceWCTab          matlab.ui.container.Tab
        GridLayout_27                   matlab.ui.container.GridLayout
        InfoPanel_27                    matlab.ui.container.Panel
        BrakingForceTestLabel_3         matlab.ui.control.Label
        Image9_27                       matlab.ui.control.Image
        Image2_34                       matlab.ui.control.Image
        CreatorDropDown_27              matlab.ui.control.DropDown
        CreatorDropDown_27Label         matlab.ui.control.Label
        FlexbodySwitch_27               matlab.ui.control.Switch
        VersionEditField_27             matlab.ui.control.EditField
        VersionEditField_27Label        matlab.ui.control.Label
        ProjectEditField_28             matlab.ui.control.EditField
        ProjectEditField_28Label        matlab.ui.control.Label
        DatePicker_27                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_27        matlab.ui.container.Panel
        TextArea_28                     matlab.ui.control.TextArea
        Lamp_27                         matlab.ui.control.Lamp
        BewertungDropDown_27            matlab.ui.control.DropDown
        UIAxesLeft_R_brakingcomp        matlab.ui.control.UIAxes
        UIAxesRight_R_brakingcomp       matlab.ui.control.UIAxes
        antiDiveTab                     matlab.ui.container.Tab
        GridLayout_32                   matlab.ui.container.GridLayout
        InfoPanel_32                    matlab.ui.container.Panel
        BrakingForceTestLabel_8         matlab.ui.control.Label
        Image9_32                       matlab.ui.control.Image
        CreatorDropDown_32              matlab.ui.control.DropDown
        CreatorDropDown_32Label         matlab.ui.control.Label
        Image2_39                       matlab.ui.control.Image
        FlexbodySwitch_32               matlab.ui.control.Switch
        VersionEditField_32             matlab.ui.control.EditField
        VersionEditField_32Label        matlab.ui.control.Label
        ProjectEditField_33             matlab.ui.control.EditField
        ProjectEditField_33Label        matlab.ui.control.Label
        DatePicker_32                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_32        matlab.ui.container.Panel
        TextArea_33                     matlab.ui.control.TextArea
        Lamp_32                         matlab.ui.control.Lamp
        BewertungDropDown_32            matlab.ui.control.DropDown
        UIAxesLeft_R_brakingantidive    matlab.ui.control.UIAxes
        UIAxesRight_R_brakingantidive   matlab.ui.control.UIAxes
        brakingSpinTab                  matlab.ui.container.Tab
        GridLayout_28                   matlab.ui.container.GridLayout
        InfoPanel_28                    matlab.ui.container.Panel
        BrakingForceTestLabel_4         matlab.ui.control.Label
        Image9_28                       matlab.ui.control.Image
        Image2_35                       matlab.ui.control.Image
        CreatorDropDown_28              matlab.ui.control.DropDown
        CreatorDropDown_28Label         matlab.ui.control.Label
        FlexbodySwitch_28               matlab.ui.control.Switch
        VersionEditField_28             matlab.ui.control.EditField
        VersionEditField_28Label        matlab.ui.control.Label
        ProjectEditField_29             matlab.ui.control.EditField
        ProjectEditField_29Label        matlab.ui.control.Label
        DatePicker_28                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_28        matlab.ui.container.Panel
        TextArea_29                     matlab.ui.control.TextArea
        Lamp_28                         matlab.ui.control.Lamp
        BewertungDropDown_28            matlab.ui.control.DropDown
        UIAxesLeft_R_brakingspin        matlab.ui.control.UIAxes
        UIAxesRight_R_brakingspin       matlab.ui.control.UIAxes
        brakingInclinationTab           matlab.ui.container.Tab
        GridLayout_29                   matlab.ui.container.GridLayout
        InfoPanel_29                    matlab.ui.container.Panel
        BrakingForceTestLabel_5         matlab.ui.control.Label
        Image9_29                       matlab.ui.control.Image
        Image2_36                       matlab.ui.control.Image
        CreatorDropDown_29              matlab.ui.control.DropDown
        CreatorDropDown_29Label         matlab.ui.control.Label
        FlexbodySwitch_29               matlab.ui.control.Switch
        VersionEditField_29             matlab.ui.control.EditField
        VersionEditField_29Label        matlab.ui.control.Label
        ProjectEditField_30             matlab.ui.control.EditField
        ProjectEditField_30Label        matlab.ui.control.Label
        DatePicker_29                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_29        matlab.ui.container.Panel
        TextArea_30                     matlab.ui.control.TextArea
        Lamp_29                         matlab.ui.control.Lamp
        BewertungDropDown_29            matlab.ui.control.DropDown
        UIAxesLeft_R_brakinginc         matlab.ui.control.UIAxes
        UIAxesRight_R_brakinginc        matlab.ui.control.UIAxes
        brakingScrubTab                 matlab.ui.container.Tab
        GridLayout_30                   matlab.ui.container.GridLayout
        InfoPanel_30                    matlab.ui.container.Panel
        BrakingForceTestLabel_6         matlab.ui.control.Label
        Image9_30                       matlab.ui.control.Image
        CreatorDropDown_30              matlab.ui.control.DropDown
        CreatorDropDown_30Label         matlab.ui.control.Label
        Image2_37                       matlab.ui.control.Image
        FlexbodySwitch_30               matlab.ui.control.Switch
        VersionEditField_30             matlab.ui.control.EditField
        VersionEditField_30Label        matlab.ui.control.Label
        ProjectEditField_31             matlab.ui.control.EditField
        ProjectEditField_31Label        matlab.ui.control.Label
        DatePicker_30                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_30        matlab.ui.container.Panel
        TextArea_31                     matlab.ui.control.TextArea
        Lamp_30                         matlab.ui.control.Lamp
        BewertungDropDown_30            matlab.ui.control.DropDown
        UIAxesLeft_R_brakingsr          matlab.ui.control.UIAxes
        UIAxesRight_R_brakingsr         matlab.ui.control.UIAxes
        brakingCasterArmTab             matlab.ui.container.Tab
        GridLayout_31                   matlab.ui.container.GridLayout
        InfoPanel_31                    matlab.ui.container.Panel
        BrakingForceTestLabel_7         matlab.ui.control.Label
        Image9_31                       matlab.ui.control.Image
        CreatorDropDown_31              matlab.ui.control.DropDown
        CreatorDropDown_31Label         matlab.ui.control.Label
        Image2_38                       matlab.ui.control.Image
        FlexbodySwitch_31               matlab.ui.control.Switch
        VersionEditField_31             matlab.ui.control.EditField
        VersionEditField_31Label        matlab.ui.control.Label
        ProjectEditField_32             matlab.ui.control.EditField
        ProjectEditField_32Label        matlab.ui.control.Label
        DatePicker_31                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_31        matlab.ui.container.Panel
        TextArea_32                     matlab.ui.control.TextArea
        Lamp_31                         matlab.ui.control.Lamp
        BewertungDropDown_31            matlab.ui.control.DropDown
        UIAxesLeft_R_brakingcma         matlab.ui.control.UIAxes
        UIAxesRight_R_brakingcma        matlab.ui.control.UIAxes
        mmLabel_R_braking_rangshow      matlab.ui.control.Label
        EditField_R_braking_rangeshow   matlab.ui.control.NumericEditField
        Tab_KcRear_Accel                matlab.ui.container.Tab
        Button_10                       matlab.ui.control.Button
        Button_9                        matlab.ui.control.Button
        VWUPButton_5                    matlab.ui.control.StateButton
        VWGolfButton_6                  matlab.ui.control.StateButton
        TwistBeamLabel_5                matlab.ui.control.Label
        ABDSPMMPlusLabel_15             matlab.ui.control.Label
        BYDDolphinButton_5              matlab.ui.control.StateButton
        TOYOTAYarisButton_5             matlab.ui.control.StateButton
        BMW325iButton_5                 matlab.ui.control.StateButton
        VWID3Button_5                   matlab.ui.control.StateButton
        TestReportLabel_5               matlab.ui.control.Label
        ABDSPMMPlusLabel_14             matlab.ui.control.Label
        TestBenchResultsLabel_5         matlab.ui.control.Label
        ABDSPMMPlusLabel_13             matlab.ui.control.Label
        RefVehicleLabel_10              matlab.ui.control.Label
        FORDEDGEButton_10               matlab.ui.control.StateButton
        TeslaModel3Button_10            matlab.ui.control.StateButton
        VWPassatButton_10               matlab.ui.control.StateButton
        BYDDelphinButton_10             matlab.ui.control.StateButton
        FittingRangeKnob_R_accel        matlab.ui.control.DiscreteKnob
        FittingRangeKnob_2Label_4       matlab.ui.control.Label
        EditField_browser_R_accel       matlab.ui.control.EditField
        CurrentFileLabel_5              matlab.ui.control.Label
        Button_browser_R_accel          matlab.ui.control.Button
        GOButton_R_accel                matlab.ui.control.Button
        ResultsPanel_R_accel            matlab.ui.container.Panel
        GridLayout3_4                   matlab.ui.container.GridLayout
        NRACTargetLabel_4               matlab.ui.control.Label
        PositivDirectionButton_5        matlab.ui.control.Button
        AccelClearAxesButton            matlab.ui.control.Button
        mmLabel_15                      matlab.ui.control.Label
        mmLabel_14                      matlab.ui.control.Label
        Label_15                        matlab.ui.control.Label
        Label_14                        matlab.ui.control.Label
        mmkNLabel_3                     matlab.ui.control.Label
        kNLabel_8                       matlab.ui.control.Label
        Label_13                        matlab.ui.control.Label
        kNLabel_7                       matlab.ui.control.Label
        accelcmaEditField               matlab.ui.control.NumericEditField
        CasterMomentArmLabel_3          matlab.ui.control.Label
        accelsrEditField                matlab.ui.control.NumericEditField
        ScrubRadiusLabel_3              matlab.ui.control.Label
        accelincEditField               matlab.ui.control.NumericEditField
        KingpinInclinationAngleLabel_3  matlab.ui.control.Label
        accelspinEditField              matlab.ui.control.NumericEditField
        KingpinCasterAngleLabel_3       matlab.ui.control.Label
        accelcompEditField              matlab.ui.control.NumericEditField
        LatForceComplianceWCLabel_3     matlab.ui.control.Label
        accelcamberEditField            matlab.ui.control.NumericEditField
        BrakeCamberChangeLabel_2        matlab.ui.control.Label
        accelantidiveEditField          matlab.ui.control.NumericEditField
        LatForceToeChangeLabel_6        matlab.ui.control.Label
        acceltoeEditField               matlab.ui.control.NumericEditField
        LatForceToeChangeLabel_5        matlab.ui.control.Label
        tbdLabel_28                     matlab.ui.control.Label
        tbdLabel_27                     matlab.ui.control.Label
        tbdLabel_26                     matlab.ui.control.Label
        tbdLabel_25                     matlab.ui.control.Label
        tbdLabel_24                     matlab.ui.control.Label
        tbdLabel_23                     matlab.ui.control.Label
        tbdLabel_22                     matlab.ui.control.Label
        Label_12                        matlab.ui.control.Label
        TabGroup_R_accel_results        matlab.ui.container.TabGroup
        accelSteerTab                   matlab.ui.container.Tab
        GridLayout_33                   matlab.ui.container.GridLayout
        ResultEvaluationPanel_33        matlab.ui.container.Panel
        TextArea_34                     matlab.ui.control.TextArea
        Lamp_33                         matlab.ui.control.Lamp
        BewertungDropDown_33            matlab.ui.control.DropDown
        InfoPanel_33                    matlab.ui.container.Panel
        ProjectEditField_34             matlab.ui.control.EditField
        ProjectEditField_34Label        matlab.ui.control.Label
        AccelerationForceTestLabel_8    matlab.ui.control.Label
        Image9_33                       matlab.ui.control.Image
        Image2_40                       matlab.ui.control.Image
        CreatorDropDown_33              matlab.ui.control.DropDown
        CreatorDropDown_33Label         matlab.ui.control.Label
        FlexbodySwitch_33               matlab.ui.control.Switch
        VersionEditField_33             matlab.ui.control.EditField
        VersionEditField_33Label        matlab.ui.control.Label
        DatePicker_33                   matlab.ui.control.DatePicker
        UIAxesLeft_R_acceltoe           matlab.ui.control.UIAxes
        UIAxesRight_R_acceltoe          matlab.ui.control.UIAxes
        accelCamberTab                  matlab.ui.container.Tab
        GridLayout_34                   matlab.ui.container.GridLayout
        InfoPanel_34                    matlab.ui.container.Panel
        AccelerationForceTestLabel_7    matlab.ui.control.Label
        Image9_34                       matlab.ui.control.Image
        Image2_41                       matlab.ui.control.Image
        CreatorDropDown_34              matlab.ui.control.DropDown
        CreatorDropDown_34Label         matlab.ui.control.Label
        FlexbodySwitch_34               matlab.ui.control.Switch
        VersionEditField_34             matlab.ui.control.EditField
        VersionEditField_34Label        matlab.ui.control.Label
        ProjectEditField_35             matlab.ui.control.EditField
        ProjectEditField_35Label        matlab.ui.control.Label
        DatePicker_34                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_34        matlab.ui.container.Panel
        TextArea_35                     matlab.ui.control.TextArea
        Lamp_34                         matlab.ui.control.Lamp
        BewertungDropDown_34            matlab.ui.control.DropDown
        UIAxesLeft_R_accelcamber        matlab.ui.control.UIAxes
        UIAxesRight_R_accelcamber       matlab.ui.control.UIAxes
        accelComplianceWCTab            matlab.ui.container.Tab
        GridLayout_35                   matlab.ui.container.GridLayout
        InfoPanel_35                    matlab.ui.container.Panel
        AccelerationForceTestLabel_6    matlab.ui.control.Label
        Image9_35                       matlab.ui.control.Image
        Image2_42                       matlab.ui.control.Image
        CreatorDropDown_35              matlab.ui.control.DropDown
        CreatorDropDown_35Label         matlab.ui.control.Label
        FlexbodySwitch_35               matlab.ui.control.Switch
        VersionEditField_35             matlab.ui.control.EditField
        VersionEditField_35Label        matlab.ui.control.Label
        ProjectEditField_36             matlab.ui.control.EditField
        ProjectEditField_36Label        matlab.ui.control.Label
        DatePicker_35                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_35        matlab.ui.container.Panel
        TextArea_36                     matlab.ui.control.TextArea
        Lamp_35                         matlab.ui.control.Lamp
        BewertungDropDown_35            matlab.ui.control.DropDown
        UIAxesLeft_R_accelcomp          matlab.ui.control.UIAxes
        UIAxesRight_R_accelcomp         matlab.ui.control.UIAxes
        antiSquatTab                    matlab.ui.container.Tab
        GridLayout_36                   matlab.ui.container.GridLayout
        InfoPanel_36                    matlab.ui.container.Panel
        AccelerationForceTestLabel_5    matlab.ui.control.Label
        Image9_36                       matlab.ui.control.Image
        CreatorDropDown_36              matlab.ui.control.DropDown
        CreatorDropDown_36Label         matlab.ui.control.Label
        Image2_43                       matlab.ui.control.Image
        FlexbodySwitch_36               matlab.ui.control.Switch
        VersionEditField_36             matlab.ui.control.EditField
        VersionEditField_36Label        matlab.ui.control.Label
        ProjectEditField_37             matlab.ui.control.EditField
        ProjectEditField_37Label        matlab.ui.control.Label
        DatePicker_36                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_36        matlab.ui.container.Panel
        TextArea_37                     matlab.ui.control.TextArea
        Lamp_36                         matlab.ui.control.Lamp
        BewertungDropDown_36            matlab.ui.control.DropDown
        UIAxesLeft_R_accelantidive      matlab.ui.control.UIAxes
        UIAxesRight_R_accelantidive     matlab.ui.control.UIAxes
        accelSpinTab                    matlab.ui.container.Tab
        GridLayout_37                   matlab.ui.container.GridLayout
        InfoPanel_37                    matlab.ui.container.Panel
        AccelerationForceTestLabel_4    matlab.ui.control.Label
        Image9_37                       matlab.ui.control.Image
        Image2_44                       matlab.ui.control.Image
        CreatorDropDown_37              matlab.ui.control.DropDown
        CreatorDropDown_37Label         matlab.ui.control.Label
        FlexbodySwitch_37               matlab.ui.control.Switch
        VersionEditField_37             matlab.ui.control.EditField
        VersionEditField_37Label        matlab.ui.control.Label
        ProjectEditField_38             matlab.ui.control.EditField
        ProjectEditField_38Label        matlab.ui.control.Label
        DatePicker_37                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_37        matlab.ui.container.Panel
        TextArea_38                     matlab.ui.control.TextArea
        Lamp_37                         matlab.ui.control.Lamp
        BewertungDropDown_37            matlab.ui.control.DropDown
        UIAxesLeft_R_accelspin          matlab.ui.control.UIAxes
        UIAxesRight_R_accelspin         matlab.ui.control.UIAxes
        accelInclinationTab             matlab.ui.container.Tab
        GridLayout_38                   matlab.ui.container.GridLayout
        InfoPanel_38                    matlab.ui.container.Panel
        AccelerationForceTestLabel_3    matlab.ui.control.Label
        Image9_38                       matlab.ui.control.Image
        Image2_45                       matlab.ui.control.Image
        CreatorDropDown_38              matlab.ui.control.DropDown
        CreatorDropDown_38Label         matlab.ui.control.Label
        FlexbodySwitch_38               matlab.ui.control.Switch
        VersionEditField_38             matlab.ui.control.EditField
        VersionEditField_38Label        matlab.ui.control.Label
        ProjectEditField_39             matlab.ui.control.EditField
        ProjectEditField_39Label        matlab.ui.control.Label
        DatePicker_38                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_38        matlab.ui.container.Panel
        TextArea_39                     matlab.ui.control.TextArea
        Lamp_38                         matlab.ui.control.Lamp
        BewertungDropDown_38            matlab.ui.control.DropDown
        UIAxesLeft_R_accelinc           matlab.ui.control.UIAxes
        UIAxesRight_R_accelinc          matlab.ui.control.UIAxes
        accelScrubTab                   matlab.ui.container.Tab
        GridLayout_39                   matlab.ui.container.GridLayout
        InfoPanel_39                    matlab.ui.container.Panel
        AccelerationForceTestLabel_2    matlab.ui.control.Label
        Image9_39                       matlab.ui.control.Image
        CreatorDropDown_39              matlab.ui.control.DropDown
        CreatorDropDown_39Label         matlab.ui.control.Label
        Image2_46                       matlab.ui.control.Image
        FlexbodySwitch_39               matlab.ui.control.Switch
        VersionEditField_39             matlab.ui.control.EditField
        VersionEditField_39Label        matlab.ui.control.Label
        ProjectEditField_40             matlab.ui.control.EditField
        ProjectEditField_40Label        matlab.ui.control.Label
        DatePicker_39                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_39        matlab.ui.container.Panel
        TextArea_40                     matlab.ui.control.TextArea
        Lamp_39                         matlab.ui.control.Lamp
        BewertungDropDown_39            matlab.ui.control.DropDown
        UIAxesLeft_R_accelsr            matlab.ui.control.UIAxes
        UIAxesRight_R_accelsr           matlab.ui.control.UIAxes
        accelCasterArmTab               matlab.ui.container.Tab
        GridLayout_40                   matlab.ui.container.GridLayout
        InfoPanel_40                    matlab.ui.container.Panel
        AccelerationForceTestLabel      matlab.ui.control.Label
        Image9_40                       matlab.ui.control.Image
        CreatorDropDown_40              matlab.ui.control.DropDown
        CreatorDropDown_40Label         matlab.ui.control.Label
        Image2_47                       matlab.ui.control.Image
        FlexbodySwitch_40               matlab.ui.control.Switch
        VersionEditField_40             matlab.ui.control.EditField
        VersionEditField_40Label        matlab.ui.control.Label
        ProjectEditField_41             matlab.ui.control.EditField
        ProjectEditField_41Label        matlab.ui.control.Label
        DatePicker_40                   matlab.ui.control.DatePicker
        ResultEvaluationPanel_40        matlab.ui.container.Panel
        TextArea_41                     matlab.ui.control.TextArea
        Lamp_40                         matlab.ui.control.Lamp
        BewertungDropDown_40            matlab.ui.control.DropDown
        UIAxesLeft_R_accelcma           matlab.ui.control.UIAxes
        UIAxesRight_R_accelcma          matlab.ui.control.UIAxes
        mmLabel_R_accel_rangshow        matlab.ui.control.Label
        EditField_R_accel_rangeshow     matlab.ui.control.NumericEditField
        Tab_KcRear_AlignTorque          matlab.ui.container.Tab
        RefVehicleLabel_6               matlab.ui.control.Label
        FORDEDGEButton_6                matlab.ui.control.StateButton
        TeslaModel3Button_6             matlab.ui.control.StateButton
        VWPassatButton_6                matlab.ui.control.StateButton
        BYDDelphinButton_6              matlab.ui.control.StateButton
        Tab_KC_front                    matlab.ui.container.Tab
        BatchAllFrontSuspensionTab      matlab.ui.container.Tab
        BatchAllRearSuspensionTab       matlab.ui.container.Tab
        VariantandCoordinateSysTab      matlab.ui.container.Tab
        HelpButton                      matlab.ui.control.Button
        QuitButton                      matlab.ui.control.Button
    end


    
    methods (Access = private)
        
        function static_load(app, filedir)

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
            %建立以filename为名字的excel结果输出文件
            %dname=uigetdir(pathname);
            %filename1=[dname,'\',char(regexp(filename,'\w*(?=.res)','match')),'.xlsx'];
            %
            %------------------------------------------------------------------------------------按不同的K&Cd工况开始进行输出---------------------------------------------------------------------%
            %                                                                                                                                                                                   %
            % 1.parallel_travel   2.opposite_travel   3.steering   4.static_loads_lat   5.static_load_long   6.static_load_align_torque                                                         %
            %                                                                                                                                                                                   %
            %                                                                                                                                                                                   %
            %-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%


            %------------------------------------------------------------Static load工况--------------------------------------------------------------------------------
            
            KinBenchTool_StaticLoad_Plot

        end
        %close(h0);
        %        fclose('all');
        %elapsedTime = toc(timerVal);
        %end


    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function
        function TryButtonPushed(app, event)
            app.BeschreibungTextArea.Value = "Quan a good man!";
        end

        % Button pushed function: HelpButton
        function HelpButtonPushed(app, event)
            msgbox("1234", "help")
        end

        % Button pushed function: QuitButton
        function QuitButtonPushed(app, event)
            
            QuitChoose = questdlg("Do you want to close?","关闭","Yes", "No", "Yes");
            
            switch QuitChoose
                case "Yes"
                    delete(app.UIFigure)
                    return
                case "No"
                    return
            end      

        end

        % Button pushed function: Button_browser_R_roll
        function Button_browser_R_rollPushed(app, event)
            [filename,pathname]=uigetfile('*.res','Select the Adams res file','MultiSelect', 'off');% 打开文件选择对话框
            if filename ~= 0
                app.EditField_browser_R_roll.Value = fullfile(pathname, filename);
            end
        end

        % Button pushed function: GOButton_R_roll
        function GOButton_R_rollPushed(app, event)
            KinBenchTool_Roll_Plot

        end

        % Button pushed function: Button_browser_bump
        function Button_browser_bumpPushed(app, event)
            [filename,pathname]=uigetfile('*.res','Select the Adams res file','MultiSelect', 'off');
            if filename ~= 0
                app.EditField_browser_bump.Value = fullfile(pathname, filename);
            end
        end

        % Button pushed function: GOButton_bump
        function GOButton_bumpPushed(app, event)
            KinBenchTool_Bump_Plot

        end

        % Value changed function: FittingRangeKnob
        function FittingRangeKnobValueChanged(app, event)
            value = app.FittingRangeKnob.Value;
            app.EditField_R_bump_range.Value = str2double(value);
        end

        % Value changed function: BewertungDropDown_7
        function BewertungDropDown_7ValueChanged(app, event)
            value = app.BewertungDropDown_7.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_7.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_7.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_7.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_8
        function BewertungDropDown_8ValueChanged(app, event)
            value = app.BewertungDropDown_8.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_8.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_8.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_8.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown
        function BewertungDropDownValueChanged(app, event)
            value = app.BewertungDropDown.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_2
        function BewertungDropDown_2ValueChanged(app, event)
            value = app.BewertungDropDown_2.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_2.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_2.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_2.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_3
        function BewertungDropDown_3ValueChanged(app, event)
            value = app.BewertungDropDown_3.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_3.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_3.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_3.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_4
        function BewertungDropDown_4ValueChanged(app, event)
            value = app.BewertungDropDown_4.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_4.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_4.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_4.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_5
        function BewertungDropDown_5ValueChanged(app, event)
            value = app.BewertungDropDown_5.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_5.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_5.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_5.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_6
        function BewertungDropDown_6ValueChanged(app, event)
            value = app.BewertungDropDown_6.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_6.Color = 'g';
                case 'The6current results need further optimization.'
                app.Lamp_6.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_6.Color = 'r';
            end
        end

        % Value changed function: FittingRangeKnob_R_roll
        function FittingRangeKnob_R_rollValueChanged(app, event)
            valueRoll = app.FittingRangeKnob_R_roll.Value;
            app.EditField_R_roll_range.Value = str2double(valueRoll);
        end

        % Value changed function: EditField_R_roll_range
        function EditField_R_roll_rangeValueChanged(app, event)

        end

        % Button pushed function: GOButton_R_lat
        function GOButton_R_latPushed(app, event)
            if isempty(app.EditField_browser_R_lat.Value)
                uialert(app.UIFigure, 'please select a file!', 'Error');
                return;
            end

            filedir = app.EditField_browser_R_lat.Value;

            app.static_load(filedir);

        end

        % Button pushed function: Button_browser_R_lat
        function Button_browser_R_latPushed(app, event)
           
            [filename,pathname]=uigetfile('*.res','Select the Adams res file','MultiSelect', 'off');% 打开文件选择对话框
            if filename ~= 0
                app.EditField_browser_R_lat.Value = fullfile(pathname, filename);
            end
            
        end

        % Button pushed function: Button_browser_R_braking
        function Button_browser_R_brakingPushed(app, event)
            
            [filename,pathname]=uigetfile('*.res','Select the Adams res file','MultiSelect', 'off');% 打开文件选择对话框
            if filename ~= 0
                app.EditField_browser_R_braking.Value = fullfile(pathname, filename);
            end

        end

        % Button pushed function: GOButton_R_braking
        function GOButton_R_brakingPushed(app, event)
            if isempty(app.EditField_browser_R_braking.Value)
                uialert(app.UIFigure, 'please select a file!', 'Error');
                return;
            end

            filedir = app.EditField_browser_R_braking.Value;

            app.static_load(filedir);

        end

        % Value changed function: FittingRangeKnob_R_braking
        function FittingRangeKnob_R_brakingValueChanged(app, event)
            value = app.FittingRangeKnob_R_braking.Value;
            app.EditField_R_braking_rangeshow.Value = str2double(value);
        end

        % Value changed function: FittingRangeKnob_R_lat
        function FittingRangeKnob_R_latValueChanged(app, event)
            value = app.FittingRangeKnob_R_lat.Value;
            app.EditField_R_lat_rangeshow.Value = str2double(value);
        end

        % Value changed function: FittingRangeKnob_R_accel
        function FittingRangeKnob_R_accelValueChanged(app, event)
            value = app.FittingRangeKnob_R_accel.Value;
            app.EditField_R_accel_rangeshow.Value = str2double(value);
        end

        % Button pushed function: Button_browser_R_accel
        function Button_browser_R_accelPushed(app, event)
            [filename,pathname]=uigetfile('*.res','Select the Adams res file','MultiSelect', 'off');% 打开文件选择对话框
            if filename ~= 0
                app.EditField_browser_R_accel.Value = fullfile(pathname, filename);
            end
        end

        % Button pushed function: GOButton_R_accel
        function GOButton_R_accelPushed(app, event)
            if isempty(app.EditField_browser_R_accel.Value)
                uialert(app.UIFigure, 'please select a file!', 'Error');
                return;
            end

            filedir = app.EditField_browser_R_accel.Value;

            app.static_load(filedir);
        end

        % Button pushed function: BumpClearAxesButton
        function BumpClearAxesButtonPushed(app, event)

            cla(app.UIAxesLeft_wheelload); cla(app.UIAxesRight_wheelload);
            cla(app.UIAxesLeft_R_B_Wheelrate); cla(app.UIAxesRight_R_B_Wheelrate);
            cla(app.UIAxesLeft_R_B_toe); cla(app.UIAxesRight_R_B_toe);
            cla(app.UIAxesLeft_R_B_camber); cla(app.UIAxesRight_R_B_camber);
            cla(app.UIAxesLeft_R_B_WB); cla(app.UIAxesRight_R_B_WB);
            cla(app.UIAxesLeft_Track); cla(app.UIAxesRight_Track);
            cla(app.UIAxesLeft_swa); cla(app.UIAxesRight_swa);
            cla(app.UIAxesLeft_swl); cla(app.UIAxesRight_swl);

        end

        % Callback function: ColorPicker_curve
        function ColorPicker_curveValueChanged(app, event)
            value = app.ColorPicker_curve.Value;
            app.toCompareSpinner.BackgroundColor = value;
        end

        % Button pushed function: RollClearAxesButton
        function RollClearAxesButtonPushed(app, event)
            
            cla(app.UIAxesLeft_R_R_Rollrate); cla(app.UIAxesRight_R_R_Rollrate);
            cla(app.UIAxesLeft_R_R_toe); cla(app.UIAxesRight_R_R_toe);
            cla(app.UIAxesLeft_R_R_camber); cla(app.UIAxesRight_R_R_camber);
            cla(app.UIAxesLeft_R_R_camber_ground); cla(app.UIAxesRight_R_R_camber_ground);
            cla(app.UIAxesLeft_R_R_toe_WT); cla(app.UIAxesRight_R_R_toe_WT);
            cla(app.UIAxesLeft_R_R_camber_WT); cla(app.UIAxesRight_R_R_camber_WT);
            cla(app.UIAxesLeft_R_R_rch); cla(app.UIAxesRight_R_R_rch);
            
        end

        % Button pushed function: LatClearAxesButton
        function LatClearAxesButtonPushed(app, event)
            
            cla(app.UIAxesLeft_R_latcomp); cla(app.UIAxesRight_R_latcomp);
            cla(app.UIAxesLeft_R_lattoe); cla(app.UIAxesRight_R_lattoe);
            cla(app.UIAxesLeft_R_latcamber); cla(app.UIAxesRight_R_latcamber);
            cla(app.UIAxesLeft_R_latspin); cla(app.UIAxesRight_R_latspin);
            cla(app.UIAxesLeft_R_latinc); cla(app.UIAxesRight_R_latinc);
            cla(app.UIAxesLeft_R_latsr); cla(app.UIAxesRight_R_latsr);
            cla(app.UIAxesLeft_R_latcma); cla(app.UIAxesRight_R_latcma);

        end

        % Button pushed function: BrakingClearAxesButton
        function BrakingClearAxesButtonPushed(app, event)
            
            cla(app.UIAxesLeft_R_brakingcomp); cla(app.UIAxesRight_R_brakingcomp);
            cla(app.UIAxesLeft_R_brakingtoe); cla(app.UIAxesRight_R_brakingtoe);
            cla(app.UIAxesLeft_R_brakingcamber); cla(app.UIAxesRight_R_brakingcamber);
            cla(app.UIAxesLeft_R_brakingspin); cla(app.UIAxesRight_R_brakingspin);
            cla(app.UIAxesLeft_R_brakinginc); cla(app.UIAxesRight_R_brakinginc);
            cla(app.UIAxesLeft_R_brakingsr); cla(app.UIAxesRight_R_brakingsr);
            cla(app.UIAxesLeft_R_brakingcma); cla(app.UIAxesRight_R_brakingcma);
            cla(app.UIAxesLeft_R_brakingantidive); cla(app.UIAxesRight_R_brakingantidive);
            
        end

        % Button pushed function: AccelClearAxesButton
        function AccelClearAxesButtonPushed(app, event)
            
            cla(app.UIAxesLeft_R_accelcomp); cla(app.UIAxesRight_R_accelcomp);
            cla(app.UIAxesLeft_R_acceltoe); cla(app.UIAxesRight_R_acceltoe);
            cla(app.UIAxesLeft_R_accelcamber); cla(app.UIAxesRight_R_accelcamber);
            cla(app.UIAxesLeft_R_accelspin); cla(app.UIAxesRight_R_accelspin);
            cla(app.UIAxesLeft_R_accelinc); cla(app.UIAxesRight_R_accelinc);
            cla(app.UIAxesLeft_R_accelsr); cla(app.UIAxesRight_R_accelsr);
            cla(app.UIAxesLeft_R_accelcma); cla(app.UIAxesRight_R_accelcma);
            cla(app.UIAxesLeft_R_accelantidive); cla(app.UIAxesRight_R_accelantidive);

        end

        % Value changed function: BewertungDropDown_16
        function BewertungDropDown_16ValueChanged(app, event)
            value = app.BewertungDropDown_16.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_16.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_16.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_16.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_15
        function BewertungDropDown_15ValueChanged(app, event)
            value = app.BewertungDropDown_15.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_15.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_15.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_15.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_14
        function BewertungDropDown_14ValueChanged(app, event)
            value = app.BewertungDropDown_14.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_14.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_14.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_14.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_13
        function BewertungDropDown_13ValueChanged(app, event)
            value = app.BewertungDropDown_13.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_13.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_13.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_13.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_12
        function BewertungDropDown_12ValueChanged(app, event)
            value = app.BewertungDropDown_12.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_12.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_12.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_12.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_11
        function BewertungDropDown_11ValueChanged(app, event)
            value = app.BewertungDropDown_11.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_11.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_11.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_11.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_9
        function BewertungDropDown_9ValueChanged(app, event)
            value = app.BewertungDropDown_9.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_9.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_9.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_9.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_18
        function BewertungDropDown_18ValueChanged(app, event)
            value = app.BewertungDropDown_18.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_18.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_18.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_18.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_19
        function BewertungDropDown_19ValueChanged(app, event)
            value = app.BewertungDropDown_19.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_19.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_19.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_19.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_20
        function BewertungDropDown_20ValueChanged(app, event)
            value = app.BewertungDropDown_20.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_20.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_20.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_20.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_21
        function BewertungDropDown_21ValueChanged(app, event)
            value = app.BewertungDropDown_21.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_21.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_21.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_21.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_22
        function BewertungDropDown_22ValueChanged(app, event)
            value = app.BewertungDropDown_22.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_22.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_22.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_22.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_23
        function BewertungDropDown_23ValueChanged(app, event)
            value = app.BewertungDropDown_23.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_23.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_23.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_23.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_24
        function BewertungDropDown_24ValueChanged(app, event)
            value = app.BewertungDropDown_24.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_24.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_24.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_24.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_25
        function BewertungDropDown_25ValueChanged(app, event)
            value = app.BewertungDropDown_25.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_25.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_25.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_25.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_26
        function BewertungDropDown_26ValueChanged(app, event)
            value = app.BewertungDropDown_26.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_26.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_26.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_26.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_27
        function BewertungDropDown_27ValueChanged(app, event)
            value = app.BewertungDropDown_27.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_27.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_27.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_27.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_32
        function BewertungDropDown_32ValueChanged(app, event)
            value = app.BewertungDropDown_32.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_32.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_32.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_32.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_28
        function BewertungDropDown_28ValueChanged(app, event)
            value = app.BewertungDropDown_28.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_28.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_28.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_28.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_29
        function BewertungDropDown_29ValueChanged(app, event)
            value = app.BewertungDropDown_29.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_29.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_29.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_29.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_30
        function BewertungDropDown_30ValueChanged(app, event)
            value = app.BewertungDropDown_30.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_30.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_30.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_30.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_31
        function BewertungDropDown_31ValueChanged(app, event)
            value = app.BewertungDropDown_31.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_31.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_31.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_31.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_33
        function BewertungDropDown_33ValueChanged(app, event)
            value = app.BewertungDropDown_33.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_33.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_33.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_33.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_34
        function BewertungDropDown_34ValueChanged(app, event)
            value = app.BewertungDropDown_34.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_34.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_34.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_34.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_35
        function BewertungDropDown_35ValueChanged(app, event)
            value = app.BewertungDropDown_35.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_35.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_35.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_35.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_36
        function BewertungDropDown_36ValueChanged(app, event)
            value = app.BewertungDropDown_36.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_36.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_36.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_36.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_37
        function BewertungDropDown_37ValueChanged(app, event)

            value = app.BewertungDropDown_37.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_37.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_37.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_37.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_38
        function BewertungDropDown_38ValueChanged(app, event)
            value = app.BewertungDropDown_38.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_38.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_38.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_38.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_39
        function BewertungDropDown_39ValueChanged(app, event)
            value = app.BewertungDropDown_39.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_39.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_39.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_39.Color = 'r';
            end
        end

        % Value changed function: BewertungDropDown_40
        function BewertungDropDown_40ValueChanged(app, event)
            value = app.BewertungDropDown_40.Value;
            switch value
                case 'The current results meet the requirements'
                app.Lamp_40.Color = 'g';
                case 'The current results need further optimization.'
                app.Lamp_40.Color = 'y';
                case 'The current results have serious issues.'
                app.Lamp_40.Color = 'r';
            end
        end

        % Button pushed function: Button_7
        function Button_7Pushed(app, event)
            KinBenchTool_braking_extra_plot
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1557 832];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.Resize = 'off';
            app.UIFigure.WindowStyle = 'modal';

            % Create QuitButton
            app.QuitButton = uibutton(app.UIFigure, 'push');
            app.QuitButton.ButtonPushedFcn = createCallbackFcn(app, @QuitButtonPushed, true);
            app.QuitButton.Position = [1207 12 86 23];
            app.QuitButton.Text = 'Quit';

            % Create HelpButton
            app.HelpButton = uibutton(app.UIFigure, 'push');
            app.HelpButton.ButtonPushedFcn = createCallbackFcn(app, @HelpButtonPushed, true);
            app.HelpButton.Position = [1307 12 86 23];
            app.HelpButton.Text = 'Help';

            % Create TabGroup_KC_bench
            app.TabGroup_KC_bench = uitabgroup(app.UIFigure);
            app.TabGroup_KC_bench.Position = [213 48 1199 641];

            % Create Tab_KC_rear
            app.Tab_KC_rear = uitab(app.TabGroup_KC_bench);
            app.Tab_KC_rear.Title = 'Rear Suspension';

            % Create Tab_KcRear
            app.Tab_KcRear = uitabgroup(app.Tab_KC_rear);
            app.Tab_KcRear.Position = [11 44 1173 561];

            % Create STARTINFOTab
            app.STARTINFOTab = uitab(app.Tab_KcRear);
            app.STARTINFOTab.Title = 'START/INFO...';

            % Create GridLayout5
            app.GridLayout5 = uigridlayout(app.STARTINFOTab);
            app.GridLayout5.ColumnWidth = {'8.44x', '11.62x'};
            app.GridLayout5.RowHeight = {36, 470};

            % Create TextArea_25
            app.TextArea_25 = uitextarea(app.GridLayout5);
            app.TextArea_25.FontName = 'Times New Roman';
            app.TextArea_25.FontSize = 14;
            app.TextArea_25.FontColor = [0.3922 0.8314 0.0745];
            app.TextArea_25.BackgroundColor = [0.149 0.149 0.149];
            app.TextArea_25.Layout.Row = 2;
            app.TextArea_25.Layout.Column = 2;
            app.TextArea_25.Value = {'23.01.2025'; ''; '1. Bump Test Results and Plot Check done!'; ''; '22.01.2025'; ''; '1. 把所有绘图区的字号统一调整为8，同时字体设置为Time Roman New'; '2. 更新所有绘图区的颜色灯判定函数'; ''; '05.01.2025:-------------version beta-04'; ''; '1. 为了便于对比，添加了一竖列对标车kc数据按钮，但是数据还未开始处理。'; '2. 进一步理解了kc结果的意义，重新检验各个参数正方向设定。但是在app里如何描述还未想清楚。。。'; ''; '04.01.2025:-------------version beta-03'; ''; '1. BUGs fix'; '2. 添加一键清空按钮，同时多子图可以绘制了，设定不同颜色，注意，那个计数器控制文本行在y轴的位置。'; ''; '03.01.2025:-------------version beta-03'; ''; '1. BUGs fix'; '2. 代码过于呆板冗余，代码量过大，任何增添的新代码都将是累赘，严重拖慢软件速度。'; '考虑代码重构！但是这是极大的工作量并产生过多BUG，慎重！'; ''; '02.01.2025:-------------version beta-02'; ''; '1. 后悬分析代码除AT外已经完成，但仍然存在如下问题'; 'a. 缺少进度条功能'; 'b. 缺少一建清空绘图区功能'; 'c. 缺少颜色自定义功能，少了这个就无法加载多条曲线。'; ''; '21.12.2024:-------------version beta-01'; ''; '1. 基于2021版的KinTool完成代码编辑，重新设计GUI。'; '2. 添加Acceleration的KnC结果评估。'; '3. 重新制定KnC的各个工况下参数的评估方法，参考Porscher Engineering和VW的评估方法。'};

            % Create GridLayout6
            app.GridLayout6 = uigridlayout(app.GridLayout5);
            app.GridLayout6.ColumnWidth = {'1x'};
            app.GridLayout6.RowHeight = {'1x', 160};
            app.GridLayout6.Layout.Row = 2;
            app.GridLayout6.Layout.Column = 1;

            % Create Image32
            app.Image32 = uiimage(app.GridLayout6);
            app.Image32.Layout.Row = 1;
            app.Image32.Layout.Column = 1;
            app.Image32.ImageSource = fullfile(pathToMLAPP, '—Pngtree—monkey gangster head vector illustration_6077101.png');

            % Create ReadMEPanel
            app.ReadMEPanel = uipanel(app.GridLayout6);
            app.ReadMEPanel.Title = 'Read ME';
            app.ReadMEPanel.Layout.Row = 2;
            app.ReadMEPanel.Layout.Column = 1;
            app.ReadMEPanel.FontWeight = 'bold';

            % Create ListBox
            app.ListBox = uilistbox(app.ReadMEPanel);
            app.ListBox.Items = {'1. 注意adams的计算输入，推荐使用Gestamp static loads模版或参考坐标轴 ', '2. 注意各个工况下x轴的正方向', '3. 检查整车以及悬架参数是否正确输入'};
            app.ListBox.FontColor = [0 0 1];
            app.ListBox.Position = [1 -1 459 140];
            app.ListBox.Value = '1. 注意adams的计算输入，推荐使用Gestamp static loads模版或参考坐标轴 ';

            % Create UpdateDocLabel
            app.UpdateDocLabel = uilabel(app.GridLayout5);
            app.UpdateDocLabel.FontSize = 20;
            app.UpdateDocLabel.FontWeight = 'bold';
            app.UpdateDocLabel.Layout.Row = 1;
            app.UpdateDocLabel.Layout.Column = 2;
            app.UpdateDocLabel.Text = 'Update Doc';

            % Create Tab_KcRear_Bump
            app.Tab_KcRear_Bump = uitab(app.Tab_KcRear);
            app.Tab_KcRear_Bump.Title = 'Bump Test';

            % Create CurrentFileLabel_2
            app.CurrentFileLabel_2 = uilabel(app.Tab_KcRear_Bump);
            app.CurrentFileLabel_2.HorizontalAlignment = 'right';
            app.CurrentFileLabel_2.Position = [124 500 70 22];
            app.CurrentFileLabel_2.Text = 'Current File:';

            % Create FittingRangeLabel
            app.FittingRangeLabel = uilabel(app.Tab_KcRear_Bump);
            app.FittingRangeLabel.HorizontalAlignment = 'center';
            app.FittingRangeLabel.FontName = 'Times New Roman';
            app.FittingRangeLabel.FontSize = 8;
            app.FittingRangeLabel.Position = [866 512 77 22];
            app.FittingRangeLabel.Text = 'Fitting Range=';

            % Create FittingRangeKnob
            app.FittingRangeKnob = uiknob(app.Tab_KcRear_Bump, 'discrete');
            app.FittingRangeKnob.Items = {'2', '5', '10', '15', '20'};
            app.FittingRangeKnob.ValueChangedFcn = createCallbackFcn(app, @FittingRangeKnobValueChanged, true);
            app.FittingRangeKnob.FontName = 'Times New Roman';
            app.FittingRangeKnob.FontSize = 8;
            app.FittingRangeKnob.Position = [1004 484 33 33];
            app.FittingRangeKnob.Value = '15';

            % Create EditField_R_bump_range
            app.EditField_R_bump_range = uieditfield(app.Tab_KcRear_Bump, 'numeric');
            app.EditField_R_bump_range.FontName = 'Times New Roman';
            app.EditField_R_bump_range.FontSize = 10;
            app.EditField_R_bump_range.Position = [871 491 46 18];
            app.EditField_R_bump_range.Value = 15;

            % Create mmLabel_bump_rangshow
            app.mmLabel_bump_rangshow = uilabel(app.Tab_KcRear_Bump);
            app.mmLabel_bump_rangshow.FontName = 'Times New Roman';
            app.mmLabel_bump_rangshow.Position = [918 489 56 22];
            app.mmLabel_bump_rangshow.Text = '* +/-2 mm';

            % Create TabGroup_R_bump_results
            app.TabGroup_R_bump_results = uitabgroup(app.Tab_KcRear_Bump);
            app.TabGroup_R_bump_results.Position = [304 10 756 468];

            % Create WheelRateWCTab
            app.WheelRateWCTab = uitab(app.TabGroup_R_bump_results);
            app.WheelRateWCTab.Title = 'Wheel Rate@WC';
            app.WheelRateWCTab.BackgroundColor = [1 1 1];

            % Create GridLayout_7
            app.GridLayout_7 = uigridlayout(app.WheelRateWCTab);
            app.GridLayout_7.ColumnWidth = {'5x', '5x'};
            app.GridLayout_7.RowHeight = {'24x', '8x'};
            app.GridLayout_7.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_wheelload
            app.UIAxesLeft_wheelload = uiaxes(app.GridLayout_7);
            app.UIAxesLeft_wheelload.FontName = 'Times New Roman';
            app.UIAxesLeft_wheelload.XLim = [-100 100];
            app.UIAxesLeft_wheelload.XTick = [-100 -80 -60 -40 -20 0 20 40 60 80 100];
            app.UIAxesLeft_wheelload.XTickLabel = {'-100'; '-80'; '-60'; '-40'; '-20'; '0'; '20'; '40'; '60'; '80'; '100'};
            app.UIAxesLeft_wheelload.FontSize = 10;
            app.UIAxesLeft_wheelload.Layout.Row = 1;
            app.UIAxesLeft_wheelload.Layout.Column = 1;

            % Create UIAxesRight_wheelload
            app.UIAxesRight_wheelload = uiaxes(app.GridLayout_7);
            app.UIAxesRight_wheelload.FontName = 'Times New Roman';
            app.UIAxesRight_wheelload.XLim = [-100 100];
            app.UIAxesRight_wheelload.FontSize = 10;
            app.UIAxesRight_wheelload.Layout.Row = 1;
            app.UIAxesRight_wheelload.Layout.Column = 2;

            % Create ResultEvaluationPanel_7
            app.ResultEvaluationPanel_7 = uipanel(app.GridLayout_7);
            app.ResultEvaluationPanel_7.BorderType = 'none';
            app.ResultEvaluationPanel_7.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_7.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_7.Layout.Row = 2;
            app.ResultEvaluationPanel_7.Layout.Column = 1;
            app.ResultEvaluationPanel_7.FontWeight = 'bold';

            % Create BewertungDropDown_7
            app.BewertungDropDown_7 = uidropdown(app.ResultEvaluationPanel_7);
            app.BewertungDropDown_7.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_7.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_7ValueChanged, true);
            app.BewertungDropDown_7.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_7.Position = [5 57 326 22];
            app.BewertungDropDown_7.Value = 'The current results need further optimization.';

            % Create Lamp_7
            app.Lamp_7 = uilamp(app.ResultEvaluationPanel_7);
            app.Lamp_7.Position = [336 58 20 20];
            app.Lamp_7.Color = [1 1 0.0667];

            % Create TextArea_7
            app.TextArea_7 = uitextarea(app.ResultEvaluationPanel_7);
            app.TextArea_7.Position = [5 3 352 50];

            % Create InfoPanel_8
            app.InfoPanel_8 = uipanel(app.GridLayout_7);
            app.InfoPanel_8.BorderType = 'none';
            app.InfoPanel_8.Title = 'Info.';
            app.InfoPanel_8.BackgroundColor = [1 1 1];
            app.InfoPanel_8.Layout.Row = 2;
            app.InfoPanel_8.Layout.Column = 2;
            app.InfoPanel_8.FontWeight = 'bold';

            % Create DatePicker_8
            app.DatePicker_8 = uidatepicker(app.InfoPanel_8);
            app.DatePicker_8.Position = [241 59 112 18];
            app.DatePicker_8.Value = datetime([2025 1 1]);

            % Create ProjectEditField_8Label
            app.ProjectEditField_8Label = uilabel(app.InfoPanel_8);
            app.ProjectEditField_8Label.HorizontalAlignment = 'right';
            app.ProjectEditField_8Label.Position = [4 57 46 22];
            app.ProjectEditField_8Label.Text = 'Project:';

            % Create ProjectEditField_8
            app.ProjectEditField_8 = uieditfield(app.InfoPanel_8, 'text');
            app.ProjectEditField_8.Position = [63 59 137 18];
            app.ProjectEditField_8.Value = 'Gestamp NRAC';

            % Create VersionEditField_8Label
            app.VersionEditField_8Label = uilabel(app.InfoPanel_8);
            app.VersionEditField_8Label.BackgroundColor = [1 1 1];
            app.VersionEditField_8Label.HorizontalAlignment = 'right';
            app.VersionEditField_8Label.Position = [4 31 48 22];
            app.VersionEditField_8Label.Text = 'Version:';

            % Create VersionEditField_8
            app.VersionEditField_8 = uieditfield(app.InfoPanel_8, 'text');
            app.VersionEditField_8.HorizontalAlignment = 'center';
            app.VersionEditField_8.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_8.Position = [63 34 77 17];
            app.VersionEditField_8.Value = 'G046';

            % Create FlexbodySwitch_8
            app.FlexbodySwitch_8 = uiswitch(app.InfoPanel_8, 'slider');
            app.FlexbodySwitch_8.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_8.FontSize = 9;
            app.FlexbodySwitch_8.Position = [219 34 35 16];
            app.FlexbodySwitch_8.Value = 'Flex-Off';

            % Create CreatorDropDown_8Label
            app.CreatorDropDown_8Label = uilabel(app.InfoPanel_8);
            app.CreatorDropDown_8Label.FontSize = 8;
            app.CreatorDropDown_8Label.Position = [8 4 50 22];
            app.CreatorDropDown_8Label.Text = 'Creator:';

            % Create CreatorDropDown_8
            app.CreatorDropDown_8 = uidropdown(app.InfoPanel_8);
            app.CreatorDropDown_8.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_8.FontSize = 8;
            app.CreatorDropDown_8.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_8.Position = [63 7 100 16];
            app.CreatorDropDown_8.Value = 'Q. Rong';

            % Create DatePicker_41
            app.DatePicker_41 = uidatepicker(app.InfoPanel_8);
            app.DatePicker_41.Position = [175 7 112 18];
            app.DatePicker_41.Value = datetime([2025 1 1]);

            % Create Image2_48
            app.Image2_48 = uiimage(app.InfoPanel_8);
            app.Image2_48.Position = [297 8 26 25];
            app.Image2_48.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_41
            app.Image9_41 = uiimage(app.InfoPanel_8);
            app.Image9_41.Position = [328 4 30 28];
            app.Image9_41.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create Image_kc_01_bump
            app.Image_kc_01_bump = uiimage(app.GridLayout_7);
            app.Image_kc_01_bump.ScaleMethod = 'stretch';
            app.Image_kc_01_bump.Layout.Row = 1;
            app.Image_kc_01_bump.Layout.Column = 1;
            app.Image_kc_01_bump.ImageSource = fullfile(pathToMLAPP, 'kc_pic_03.png');

            % Create Image_kc_02_bump
            app.Image_kc_02_bump = uiimage(app.GridLayout_7);
            app.Image_kc_02_bump.ScaleMethod = 'stretch';
            app.Image_kc_02_bump.Layout.Row = 1;
            app.Image_kc_02_bump.Layout.Column = 2;
            app.Image_kc_02_bump.ImageSource = fullfile(pathToMLAPP, 'kc_pic_02.png');

            % Create WheelRateSlopeWCTab
            app.WheelRateSlopeWCTab = uitab(app.TabGroup_R_bump_results);
            app.WheelRateSlopeWCTab.Title = 'Wheel Rate Slope@WC';
            app.WheelRateSlopeWCTab.BackgroundColor = [1 1 1];

            % Create GridLayout_8
            app.GridLayout_8 = uigridlayout(app.WheelRateSlopeWCTab);
            app.GridLayout_8.ColumnWidth = {'5x', '5x'};
            app.GridLayout_8.RowHeight = {'24x', '8x'};
            app.GridLayout_8.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_B_Wheelrate
            app.UIAxesLeft_R_B_Wheelrate = uiaxes(app.GridLayout_8);
            app.UIAxesLeft_R_B_Wheelrate.FontName = 'Times New Roman';
            app.UIAxesLeft_R_B_Wheelrate.XLim = [-100 100];
            app.UIAxesLeft_R_B_Wheelrate.FontSize = 10;
            app.UIAxesLeft_R_B_Wheelrate.Layout.Row = 1;
            app.UIAxesLeft_R_B_Wheelrate.Layout.Column = 1;

            % Create UIAxesRight_R_B_Wheelrate
            app.UIAxesRight_R_B_Wheelrate = uiaxes(app.GridLayout_8);
            app.UIAxesRight_R_B_Wheelrate.FontName = 'Times New Roman';
            app.UIAxesRight_R_B_Wheelrate.XLim = [-100 100];
            app.UIAxesRight_R_B_Wheelrate.FontSize = 10;
            app.UIAxesRight_R_B_Wheelrate.Layout.Row = 1;
            app.UIAxesRight_R_B_Wheelrate.Layout.Column = 2;

            % Create ResultEvaluationPanel_8
            app.ResultEvaluationPanel_8 = uipanel(app.GridLayout_8);
            app.ResultEvaluationPanel_8.BorderType = 'none';
            app.ResultEvaluationPanel_8.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_8.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_8.Layout.Row = 2;
            app.ResultEvaluationPanel_8.Layout.Column = 1;
            app.ResultEvaluationPanel_8.FontWeight = 'bold';

            % Create BewertungDropDown_8
            app.BewertungDropDown_8 = uidropdown(app.ResultEvaluationPanel_8);
            app.BewertungDropDown_8.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_8.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_8ValueChanged, true);
            app.BewertungDropDown_8.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_8.Position = [5 57 326 22];
            app.BewertungDropDown_8.Value = 'The current results need further optimization.';

            % Create Lamp_8
            app.Lamp_8 = uilamp(app.ResultEvaluationPanel_8);
            app.Lamp_8.Position = [336 58 20 20];
            app.Lamp_8.Color = [1 1 0];

            % Create TextArea_8
            app.TextArea_8 = uitextarea(app.ResultEvaluationPanel_8);
            app.TextArea_8.Position = [5 3 352 50];

            % Create InfoPanel_2
            app.InfoPanel_2 = uipanel(app.GridLayout_8);
            app.InfoPanel_2.BorderType = 'none';
            app.InfoPanel_2.Title = 'Info.';
            app.InfoPanel_2.BackgroundColor = [1 1 1];
            app.InfoPanel_2.Layout.Row = 2;
            app.InfoPanel_2.Layout.Column = 2;
            app.InfoPanel_2.FontWeight = 'bold';

            % Create DatePicker_2
            app.DatePicker_2 = uidatepicker(app.InfoPanel_2);
            app.DatePicker_2.Position = [241 59 112 18];
            app.DatePicker_2.Value = datetime([2025 1 1]);

            % Create ProjectEditField_2Label
            app.ProjectEditField_2Label = uilabel(app.InfoPanel_2);
            app.ProjectEditField_2Label.HorizontalAlignment = 'right';
            app.ProjectEditField_2Label.Position = [4 57 46 22];
            app.ProjectEditField_2Label.Text = 'Project:';

            % Create ProjectEditField_2
            app.ProjectEditField_2 = uieditfield(app.InfoPanel_2, 'text');
            app.ProjectEditField_2.Position = [63 59 137 18];
            app.ProjectEditField_2.Value = 'Gestamp NRAC';

            % Create VersionEditField_2Label
            app.VersionEditField_2Label = uilabel(app.InfoPanel_2);
            app.VersionEditField_2Label.BackgroundColor = [1 1 1];
            app.VersionEditField_2Label.HorizontalAlignment = 'right';
            app.VersionEditField_2Label.Position = [4 31 48 22];
            app.VersionEditField_2Label.Text = 'Version:';

            % Create VersionEditField_2
            app.VersionEditField_2 = uieditfield(app.InfoPanel_2, 'text');
            app.VersionEditField_2.HorizontalAlignment = 'center';
            app.VersionEditField_2.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_2.Position = [63 34 77 17];
            app.VersionEditField_2.Value = 'G046';

            % Create FlexbodySwitch_2
            app.FlexbodySwitch_2 = uiswitch(app.InfoPanel_2, 'slider');
            app.FlexbodySwitch_2.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_2.FontSize = 9;
            app.FlexbodySwitch_2.Position = [219 34 35 16];
            app.FlexbodySwitch_2.Value = 'Flex-Off';

            % Create CreatorDropDown_2Label
            app.CreatorDropDown_2Label = uilabel(app.InfoPanel_2);
            app.CreatorDropDown_2Label.FontSize = 8;
            app.CreatorDropDown_2Label.Position = [8 4 50 22];
            app.CreatorDropDown_2Label.Text = 'Creator:';

            % Create CreatorDropDown_2
            app.CreatorDropDown_2 = uidropdown(app.InfoPanel_2);
            app.CreatorDropDown_2.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_2.FontSize = 8;
            app.CreatorDropDown_2.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_2.Position = [63 7 100 16];
            app.CreatorDropDown_2.Value = 'Q. Rong';

            % Create Image2_14
            app.Image2_14 = uiimage(app.InfoPanel_2);
            app.Image2_14.Position = [297 8 26 25];
            app.Image2_14.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_7
            app.Image9_7 = uiimage(app.InfoPanel_2);
            app.Image9_7.Position = [328 4 30 28];
            app.Image9_7.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BumpSteerTab
            app.BumpSteerTab = uitab(app.TabGroup_R_bump_results);
            app.BumpSteerTab.Title = 'Bump Steer';
            app.BumpSteerTab.BackgroundColor = [1 1 1];

            % Create GridLayout
            app.GridLayout = uigridlayout(app.BumpSteerTab);
            app.GridLayout.ColumnWidth = {'5x', '5x'};
            app.GridLayout.RowHeight = {'24x', '8x'};
            app.GridLayout.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_B_toe
            app.UIAxesLeft_R_B_toe = uiaxes(app.GridLayout);
            title(app.UIAxesLeft_R_B_toe, 'Title')
            xlabel(app.UIAxesLeft_R_B_toe, 'X')
            ylabel(app.UIAxesLeft_R_B_toe, 'Y')
            zlabel(app.UIAxesLeft_R_B_toe, 'Z')
            app.UIAxesLeft_R_B_toe.FontName = 'Times New Roman';
            app.UIAxesLeft_R_B_toe.XLim = [-100 100];
            app.UIAxesLeft_R_B_toe.FontSize = 10;
            app.UIAxesLeft_R_B_toe.Layout.Row = 1;
            app.UIAxesLeft_R_B_toe.Layout.Column = 1;

            % Create UIAxesRight_R_B_toe
            app.UIAxesRight_R_B_toe = uiaxes(app.GridLayout);
            title(app.UIAxesRight_R_B_toe, 'Title')
            xlabel(app.UIAxesRight_R_B_toe, 'X')
            ylabel(app.UIAxesRight_R_B_toe, 'Y')
            zlabel(app.UIAxesRight_R_B_toe, 'Z')
            app.UIAxesRight_R_B_toe.FontName = 'Times New Roman';
            app.UIAxesRight_R_B_toe.XLim = [-100 100];
            app.UIAxesRight_R_B_toe.FontSize = 10;
            app.UIAxesRight_R_B_toe.Layout.Row = 1;
            app.UIAxesRight_R_B_toe.Layout.Column = 2;

            % Create InfoPanel
            app.InfoPanel = uipanel(app.GridLayout);
            app.InfoPanel.BorderType = 'none';
            app.InfoPanel.Title = 'Info.';
            app.InfoPanel.BackgroundColor = [1 1 1];
            app.InfoPanel.Layout.Row = 2;
            app.InfoPanel.Layout.Column = 2;
            app.InfoPanel.FontWeight = 'bold';

            % Create DatePicker
            app.DatePicker = uidatepicker(app.InfoPanel);
            app.DatePicker.Position = [241 63 112 18];
            app.DatePicker.Value = datetime([2025 1 1]);

            % Create ProjectEditFieldLabel
            app.ProjectEditFieldLabel = uilabel(app.InfoPanel);
            app.ProjectEditFieldLabel.HorizontalAlignment = 'right';
            app.ProjectEditFieldLabel.Position = [4 62 46 22];
            app.ProjectEditFieldLabel.Text = 'Project:';

            % Create ProjectEditField
            app.ProjectEditField = uieditfield(app.InfoPanel, 'text');
            app.ProjectEditField.Position = [63 63 137 18];
            app.ProjectEditField.Value = 'Gestamp NRAC';

            % Create VersionLabel
            app.VersionLabel = uilabel(app.InfoPanel);
            app.VersionLabel.BackgroundColor = [1 1 1];
            app.VersionLabel.HorizontalAlignment = 'right';
            app.VersionLabel.Position = [4 36 48 22];
            app.VersionLabel.Text = 'Version:';

            % Create VersionEditField
            app.VersionEditField = uieditfield(app.InfoPanel, 'text');
            app.VersionEditField.HorizontalAlignment = 'center';
            app.VersionEditField.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField.Position = [63 38 77 17];
            app.VersionEditField.Value = 'G046';

            % Create FlexbodySwitch
            app.FlexbodySwitch = uiswitch(app.InfoPanel, 'slider');
            app.FlexbodySwitch.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch.FontSize = 9;
            app.FlexbodySwitch.Position = [219 38 35 16];
            app.FlexbodySwitch.Value = 'Flex-Off';

            % Create CreatorDropDownLabel
            app.CreatorDropDownLabel = uilabel(app.InfoPanel);
            app.CreatorDropDownLabel.FontSize = 8;
            app.CreatorDropDownLabel.Position = [8 9 50 22];
            app.CreatorDropDownLabel.Text = 'Creator:';

            % Create CreatorDropDown
            app.CreatorDropDown = uidropdown(app.InfoPanel);
            app.CreatorDropDown.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown.FontSize = 8;
            app.CreatorDropDown.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown.Position = [63 11 100 16];
            app.CreatorDropDown.Value = 'Q. Rong';

            % Create Image2_13
            app.Image2_13 = uiimage(app.InfoPanel);
            app.Image2_13.Position = [297 12 26 25];
            app.Image2_13.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_6
            app.Image9_6 = uiimage(app.InfoPanel);
            app.Image9_6.Position = [328 8 30 28];
            app.Image9_6.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create ResultEvaluationPanel
            app.ResultEvaluationPanel = uipanel(app.GridLayout);
            app.ResultEvaluationPanel.BorderType = 'none';
            app.ResultEvaluationPanel.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel.Layout.Row = 2;
            app.ResultEvaluationPanel.Layout.Column = 1;
            app.ResultEvaluationPanel.FontWeight = 'bold';

            % Create BewertungDropDown
            app.BewertungDropDown = uidropdown(app.ResultEvaluationPanel);
            app.BewertungDropDown.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDownValueChanged, true);
            app.BewertungDropDown.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown.Position = [5 57 326 22];
            app.BewertungDropDown.Value = 'The current results need further optimization.';

            % Create Lamp
            app.Lamp = uilamp(app.ResultEvaluationPanel);
            app.Lamp.Position = [336 58 20 20];
            app.Lamp.Color = [1 1 0.0667];

            % Create TextArea
            app.TextArea = uitextarea(app.ResultEvaluationPanel);
            app.TextArea.Position = [5 3 352 50];

            % Create BumperCamberTab
            app.BumperCamberTab = uitab(app.TabGroup_R_bump_results);
            app.BumperCamberTab.Title = 'Bumper Camber';
            app.BumperCamberTab.BackgroundColor = [1 1 1];

            % Create GridLayout_2
            app.GridLayout_2 = uigridlayout(app.BumperCamberTab);
            app.GridLayout_2.ColumnWidth = {'5x', '5x'};
            app.GridLayout_2.RowHeight = {'24x', '8x'};
            app.GridLayout_2.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_B_camber
            app.UIAxesLeft_R_B_camber = uiaxes(app.GridLayout_2);
            title(app.UIAxesLeft_R_B_camber, 'Title')
            xlabel(app.UIAxesLeft_R_B_camber, 'X')
            ylabel(app.UIAxesLeft_R_B_camber, 'Y')
            zlabel(app.UIAxesLeft_R_B_camber, 'Z')
            app.UIAxesLeft_R_B_camber.FontName = 'Times New Roman';
            app.UIAxesLeft_R_B_camber.XLim = [-100 100];
            app.UIAxesLeft_R_B_camber.FontSize = 10;
            app.UIAxesLeft_R_B_camber.Layout.Row = 1;
            app.UIAxesLeft_R_B_camber.Layout.Column = 1;

            % Create UIAxesRight_R_B_camber
            app.UIAxesRight_R_B_camber = uiaxes(app.GridLayout_2);
            title(app.UIAxesRight_R_B_camber, 'Title')
            xlabel(app.UIAxesRight_R_B_camber, 'X')
            ylabel(app.UIAxesRight_R_B_camber, 'Y')
            zlabel(app.UIAxesRight_R_B_camber, 'Z')
            app.UIAxesRight_R_B_camber.FontName = 'Times New Roman';
            app.UIAxesRight_R_B_camber.XLim = [-100 100];
            app.UIAxesRight_R_B_camber.FontSize = 10;
            app.UIAxesRight_R_B_camber.Layout.Row = 1;
            app.UIAxesRight_R_B_camber.Layout.Column = 2;

            % Create ResultEvaluationPanel_2
            app.ResultEvaluationPanel_2 = uipanel(app.GridLayout_2);
            app.ResultEvaluationPanel_2.BorderType = 'none';
            app.ResultEvaluationPanel_2.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_2.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_2.Layout.Row = 2;
            app.ResultEvaluationPanel_2.Layout.Column = 1;
            app.ResultEvaluationPanel_2.FontWeight = 'bold';

            % Create BewertungDropDown_2
            app.BewertungDropDown_2 = uidropdown(app.ResultEvaluationPanel_2);
            app.BewertungDropDown_2.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_2.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_2ValueChanged, true);
            app.BewertungDropDown_2.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_2.Position = [5 57 326 22];
            app.BewertungDropDown_2.Value = 'The current results need further optimization.';

            % Create Lamp_2
            app.Lamp_2 = uilamp(app.ResultEvaluationPanel_2);
            app.Lamp_2.Position = [336 58 20 20];
            app.Lamp_2.Color = [1 1 0.0667];

            % Create TextArea_2
            app.TextArea_2 = uitextarea(app.ResultEvaluationPanel_2);
            app.TextArea_2.Position = [5 3 352 50];

            % Create InfoPanel_3
            app.InfoPanel_3 = uipanel(app.GridLayout_2);
            app.InfoPanel_3.BorderType = 'none';
            app.InfoPanel_3.Title = 'Info.';
            app.InfoPanel_3.BackgroundColor = [1 1 1];
            app.InfoPanel_3.Layout.Row = 2;
            app.InfoPanel_3.Layout.Column = 2;
            app.InfoPanel_3.FontWeight = 'bold';

            % Create DatePicker_3
            app.DatePicker_3 = uidatepicker(app.InfoPanel_3);
            app.DatePicker_3.Position = [241 59 112 18];
            app.DatePicker_3.Value = datetime([2025 1 1]);

            % Create ProjectEditField_3Label
            app.ProjectEditField_3Label = uilabel(app.InfoPanel_3);
            app.ProjectEditField_3Label.HorizontalAlignment = 'right';
            app.ProjectEditField_3Label.Position = [4 57 46 22];
            app.ProjectEditField_3Label.Text = 'Project:';

            % Create ProjectEditField_3
            app.ProjectEditField_3 = uieditfield(app.InfoPanel_3, 'text');
            app.ProjectEditField_3.Position = [63 59 137 18];
            app.ProjectEditField_3.Value = 'Gestamp NRAC';

            % Create VersionEditField_3Label
            app.VersionEditField_3Label = uilabel(app.InfoPanel_3);
            app.VersionEditField_3Label.BackgroundColor = [1 1 1];
            app.VersionEditField_3Label.HorizontalAlignment = 'right';
            app.VersionEditField_3Label.Position = [4 31 48 22];
            app.VersionEditField_3Label.Text = 'Version:';

            % Create VersionEditField_3
            app.VersionEditField_3 = uieditfield(app.InfoPanel_3, 'text');
            app.VersionEditField_3.HorizontalAlignment = 'center';
            app.VersionEditField_3.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_3.Position = [63 34 77 17];
            app.VersionEditField_3.Value = 'G046';

            % Create FlexbodySwitch_3
            app.FlexbodySwitch_3 = uiswitch(app.InfoPanel_3, 'slider');
            app.FlexbodySwitch_3.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_3.FontSize = 9;
            app.FlexbodySwitch_3.Position = [219 34 35 16];
            app.FlexbodySwitch_3.Value = 'Flex-Off';

            % Create CreatorDropDown_3Label
            app.CreatorDropDown_3Label = uilabel(app.InfoPanel_3);
            app.CreatorDropDown_3Label.FontSize = 8;
            app.CreatorDropDown_3Label.Position = [8 4 50 22];
            app.CreatorDropDown_3Label.Text = 'Creator:';

            % Create CreatorDropDown_3
            app.CreatorDropDown_3 = uidropdown(app.InfoPanel_3);
            app.CreatorDropDown_3.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_3.FontSize = 8;
            app.CreatorDropDown_3.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_3.Position = [63 7 100 16];
            app.CreatorDropDown_3.Value = 'Q. Rong';

            % Create Image2_12
            app.Image2_12 = uiimage(app.InfoPanel_3);
            app.Image2_12.Position = [297 8 26 25];
            app.Image2_12.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_5
            app.Image9_5 = uiimage(app.InfoPanel_3);
            app.Image9_5.Position = [328 4 30 28];
            app.Image9_5.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create WheelRecessionTab
            app.WheelRecessionTab = uitab(app.TabGroup_R_bump_results);
            app.WheelRecessionTab.Title = 'Wheel Recession';
            app.WheelRecessionTab.BackgroundColor = [1 1 1];

            % Create GridLayout_3
            app.GridLayout_3 = uigridlayout(app.WheelRecessionTab);
            app.GridLayout_3.ColumnWidth = {'5x', '5x'};
            app.GridLayout_3.RowHeight = {'24x', '8x'};
            app.GridLayout_3.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_B_WB
            app.UIAxesLeft_R_B_WB = uiaxes(app.GridLayout_3);
            title(app.UIAxesLeft_R_B_WB, 'Title')
            xlabel(app.UIAxesLeft_R_B_WB, 'X')
            ylabel(app.UIAxesLeft_R_B_WB, 'Y')
            zlabel(app.UIAxesLeft_R_B_WB, 'Z')
            app.UIAxesLeft_R_B_WB.FontName = 'Times New Roman';
            app.UIAxesLeft_R_B_WB.XLim = [-100 100];
            app.UIAxesLeft_R_B_WB.FontSize = 10;
            app.UIAxesLeft_R_B_WB.Layout.Row = 1;
            app.UIAxesLeft_R_B_WB.Layout.Column = 1;

            % Create UIAxesRight_R_B_WB
            app.UIAxesRight_R_B_WB = uiaxes(app.GridLayout_3);
            title(app.UIAxesRight_R_B_WB, 'Title')
            xlabel(app.UIAxesRight_R_B_WB, 'X')
            ylabel(app.UIAxesRight_R_B_WB, 'Y')
            zlabel(app.UIAxesRight_R_B_WB, 'Z')
            app.UIAxesRight_R_B_WB.FontName = 'Times New Roman';
            app.UIAxesRight_R_B_WB.XLim = [-100 100];
            app.UIAxesRight_R_B_WB.FontSize = 10;
            app.UIAxesRight_R_B_WB.Layout.Row = 1;
            app.UIAxesRight_R_B_WB.Layout.Column = 2;

            % Create ResultEvaluationPanel_3
            app.ResultEvaluationPanel_3 = uipanel(app.GridLayout_3);
            app.ResultEvaluationPanel_3.BorderType = 'none';
            app.ResultEvaluationPanel_3.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_3.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_3.Layout.Row = 2;
            app.ResultEvaluationPanel_3.Layout.Column = 1;
            app.ResultEvaluationPanel_3.FontWeight = 'bold';

            % Create BewertungDropDown_3
            app.BewertungDropDown_3 = uidropdown(app.ResultEvaluationPanel_3);
            app.BewertungDropDown_3.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_3.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_3ValueChanged, true);
            app.BewertungDropDown_3.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_3.Position = [5 57 326 22];
            app.BewertungDropDown_3.Value = 'The current results need further optimization.';

            % Create Lamp_3
            app.Lamp_3 = uilamp(app.ResultEvaluationPanel_3);
            app.Lamp_3.Position = [336 58 20 20];
            app.Lamp_3.Color = [1 1 0.0667];

            % Create TextArea_3
            app.TextArea_3 = uitextarea(app.ResultEvaluationPanel_3);
            app.TextArea_3.Position = [5 3 352 50];

            % Create InfoPanel_4
            app.InfoPanel_4 = uipanel(app.GridLayout_3);
            app.InfoPanel_4.BorderType = 'none';
            app.InfoPanel_4.Title = 'Info.';
            app.InfoPanel_4.BackgroundColor = [1 1 1];
            app.InfoPanel_4.Layout.Row = 2;
            app.InfoPanel_4.Layout.Column = 2;
            app.InfoPanel_4.FontWeight = 'bold';

            % Create DatePicker_4
            app.DatePicker_4 = uidatepicker(app.InfoPanel_4);
            app.DatePicker_4.Position = [241 59 112 18];
            app.DatePicker_4.Value = datetime([2025 1 1]);

            % Create ProjectEditField_4Label
            app.ProjectEditField_4Label = uilabel(app.InfoPanel_4);
            app.ProjectEditField_4Label.HorizontalAlignment = 'right';
            app.ProjectEditField_4Label.Position = [4 57 46 22];
            app.ProjectEditField_4Label.Text = 'Project:';

            % Create ProjectEditField_4
            app.ProjectEditField_4 = uieditfield(app.InfoPanel_4, 'text');
            app.ProjectEditField_4.Position = [63 59 137 18];
            app.ProjectEditField_4.Value = 'Gestamp NRAC';

            % Create VersionEditField_4Label
            app.VersionEditField_4Label = uilabel(app.InfoPanel_4);
            app.VersionEditField_4Label.BackgroundColor = [1 1 1];
            app.VersionEditField_4Label.HorizontalAlignment = 'right';
            app.VersionEditField_4Label.Position = [4 31 48 22];
            app.VersionEditField_4Label.Text = 'Version:';

            % Create VersionEditField_4
            app.VersionEditField_4 = uieditfield(app.InfoPanel_4, 'text');
            app.VersionEditField_4.HorizontalAlignment = 'center';
            app.VersionEditField_4.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_4.Position = [63 34 77 17];
            app.VersionEditField_4.Value = 'G046';

            % Create FlexbodySwitch_4
            app.FlexbodySwitch_4 = uiswitch(app.InfoPanel_4, 'slider');
            app.FlexbodySwitch_4.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_4.FontSize = 9;
            app.FlexbodySwitch_4.Position = [219 34 35 16];
            app.FlexbodySwitch_4.Value = 'Flex-Off';

            % Create CreatorDropDown_4Label
            app.CreatorDropDown_4Label = uilabel(app.InfoPanel_4);
            app.CreatorDropDown_4Label.FontSize = 8;
            app.CreatorDropDown_4Label.Position = [8 4 50 22];
            app.CreatorDropDown_4Label.Text = 'Creator:';

            % Create CreatorDropDown_4
            app.CreatorDropDown_4 = uidropdown(app.InfoPanel_4);
            app.CreatorDropDown_4.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_4.FontSize = 8;
            app.CreatorDropDown_4.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_4.Position = [63 7 100 16];
            app.CreatorDropDown_4.Value = 'Q. Rong';

            % Create Image2_11
            app.Image2_11 = uiimage(app.InfoPanel_4);
            app.Image2_11.Position = [297 8 26 25];
            app.Image2_11.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_4
            app.Image9_4 = uiimage(app.InfoPanel_4);
            app.Image9_4.Position = [328 4 30 28];
            app.Image9_4.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create TrackChangeTab
            app.TrackChangeTab = uitab(app.TabGroup_R_bump_results);
            app.TrackChangeTab.Title = 'Track Change';
            app.TrackChangeTab.BackgroundColor = [1 1 1];

            % Create GridLayout_4
            app.GridLayout_4 = uigridlayout(app.TrackChangeTab);
            app.GridLayout_4.ColumnWidth = {'5x', '5x'};
            app.GridLayout_4.RowHeight = {'24x', '8x'};
            app.GridLayout_4.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_Track
            app.UIAxesLeft_Track = uiaxes(app.GridLayout_4);
            title(app.UIAxesLeft_Track, 'Title')
            xlabel(app.UIAxesLeft_Track, 'X')
            ylabel(app.UIAxesLeft_Track, 'Y')
            zlabel(app.UIAxesLeft_Track, 'Z')
            app.UIAxesLeft_Track.FontName = 'Times New Roman';
            app.UIAxesLeft_Track.XLim = [-100 100];
            app.UIAxesLeft_Track.FontSize = 10;
            app.UIAxesLeft_Track.Layout.Row = 1;
            app.UIAxesLeft_Track.Layout.Column = 1;

            % Create UIAxesRight_Track
            app.UIAxesRight_Track = uiaxes(app.GridLayout_4);
            title(app.UIAxesRight_Track, 'Title')
            xlabel(app.UIAxesRight_Track, 'X')
            ylabel(app.UIAxesRight_Track, 'Y')
            zlabel(app.UIAxesRight_Track, 'Z')
            app.UIAxesRight_Track.FontName = 'Times New Roman';
            app.UIAxesRight_Track.XLim = [-100 100];
            app.UIAxesRight_Track.FontSize = 10;
            app.UIAxesRight_Track.Layout.Row = 1;
            app.UIAxesRight_Track.Layout.Column = 2;

            % Create ResultEvaluationPanel_4
            app.ResultEvaluationPanel_4 = uipanel(app.GridLayout_4);
            app.ResultEvaluationPanel_4.BorderType = 'none';
            app.ResultEvaluationPanel_4.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_4.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_4.Layout.Row = 2;
            app.ResultEvaluationPanel_4.Layout.Column = 1;
            app.ResultEvaluationPanel_4.FontWeight = 'bold';

            % Create BewertungDropDown_4
            app.BewertungDropDown_4 = uidropdown(app.ResultEvaluationPanel_4);
            app.BewertungDropDown_4.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_4.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_4ValueChanged, true);
            app.BewertungDropDown_4.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_4.Position = [5 57 326 22];
            app.BewertungDropDown_4.Value = 'The current results need further optimization.';

            % Create Lamp_4
            app.Lamp_4 = uilamp(app.ResultEvaluationPanel_4);
            app.Lamp_4.Position = [336 58 20 20];
            app.Lamp_4.Color = [1 1 0];

            % Create TextArea_4
            app.TextArea_4 = uitextarea(app.ResultEvaluationPanel_4);
            app.TextArea_4.Position = [5 3 352 50];

            % Create InfoPanel_5
            app.InfoPanel_5 = uipanel(app.GridLayout_4);
            app.InfoPanel_5.BorderType = 'none';
            app.InfoPanel_5.Title = 'Info.';
            app.InfoPanel_5.BackgroundColor = [1 1 1];
            app.InfoPanel_5.Layout.Row = 2;
            app.InfoPanel_5.Layout.Column = 2;
            app.InfoPanel_5.FontWeight = 'bold';

            % Create DatePicker_5
            app.DatePicker_5 = uidatepicker(app.InfoPanel_5);
            app.DatePicker_5.Position = [241 59 112 18];
            app.DatePicker_5.Value = datetime([2025 1 1]);

            % Create ProjectEditField_5Label
            app.ProjectEditField_5Label = uilabel(app.InfoPanel_5);
            app.ProjectEditField_5Label.HorizontalAlignment = 'right';
            app.ProjectEditField_5Label.Position = [4 57 46 22];
            app.ProjectEditField_5Label.Text = 'Project:';

            % Create ProjectEditField_5
            app.ProjectEditField_5 = uieditfield(app.InfoPanel_5, 'text');
            app.ProjectEditField_5.Position = [63 59 137 18];
            app.ProjectEditField_5.Value = 'Gestamp NRAC';

            % Create VersionEditField_5Label
            app.VersionEditField_5Label = uilabel(app.InfoPanel_5);
            app.VersionEditField_5Label.BackgroundColor = [1 1 1];
            app.VersionEditField_5Label.HorizontalAlignment = 'right';
            app.VersionEditField_5Label.Position = [4 31 48 22];
            app.VersionEditField_5Label.Text = 'Version:';

            % Create VersionEditField_5
            app.VersionEditField_5 = uieditfield(app.InfoPanel_5, 'text');
            app.VersionEditField_5.HorizontalAlignment = 'center';
            app.VersionEditField_5.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_5.Position = [63 34 77 17];
            app.VersionEditField_5.Value = 'G046';

            % Create FlexbodySwitch_5
            app.FlexbodySwitch_5 = uiswitch(app.InfoPanel_5, 'slider');
            app.FlexbodySwitch_5.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_5.FontSize = 9;
            app.FlexbodySwitch_5.Position = [219 34 35 16];
            app.FlexbodySwitch_5.Value = 'Flex-Off';

            % Create CreatorDropDown_5Label
            app.CreatorDropDown_5Label = uilabel(app.InfoPanel_5);
            app.CreatorDropDown_5Label.FontSize = 8;
            app.CreatorDropDown_5Label.Position = [8 4 50 22];
            app.CreatorDropDown_5Label.Text = 'Creator:';

            % Create CreatorDropDown_5
            app.CreatorDropDown_5 = uidropdown(app.InfoPanel_5);
            app.CreatorDropDown_5.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_5.FontSize = 8;
            app.CreatorDropDown_5.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_5.Position = [63 7 100 16];
            app.CreatorDropDown_5.Value = 'Q. Rong';

            % Create Image2_10
            app.Image2_10 = uiimage(app.InfoPanel_5);
            app.Image2_10.Position = [297 8 26 25];
            app.Image2_10.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_3
            app.Image9_3 = uiimage(app.InfoPanel_5);
            app.Image9_3.Position = [328 4 30 28];
            app.Image9_3.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create CastorAngleTab
            app.CastorAngleTab = uitab(app.TabGroup_R_bump_results);
            app.CastorAngleTab.Title = 'Castor Angle';
            app.CastorAngleTab.BackgroundColor = [1 1 1];

            % Create GridLayout_41
            app.GridLayout_41 = uigridlayout(app.CastorAngleTab);
            app.GridLayout_41.ColumnWidth = {'5x', '5x'};
            app.GridLayout_41.RowHeight = {'24x', '8x'};
            app.GridLayout_41.BackgroundColor = [1 1 1];

            % Create UIAxesRight_Castor
            app.UIAxesRight_Castor = uiaxes(app.GridLayout_41);
            title(app.UIAxesRight_Castor, 'Title')
            xlabel(app.UIAxesRight_Castor, 'X')
            ylabel(app.UIAxesRight_Castor, 'Y')
            zlabel(app.UIAxesRight_Castor, 'Z')
            app.UIAxesRight_Castor.FontName = 'Times New Roman';
            app.UIAxesRight_Castor.XLim = [-100 100];
            app.UIAxesRight_Castor.FontSize = 10;
            app.UIAxesRight_Castor.Layout.Row = 1;
            app.UIAxesRight_Castor.Layout.Column = 2;

            % Create UIAxesLeft_Castor
            app.UIAxesLeft_Castor = uiaxes(app.GridLayout_41);
            title(app.UIAxesLeft_Castor, 'Title')
            xlabel(app.UIAxesLeft_Castor, 'X')
            ylabel(app.UIAxesLeft_Castor, 'Y')
            zlabel(app.UIAxesLeft_Castor, 'Z')
            app.UIAxesLeft_Castor.FontName = 'Times New Roman';
            app.UIAxesLeft_Castor.XLim = [-100 100];
            app.UIAxesLeft_Castor.FontSize = 10;
            app.UIAxesLeft_Castor.Layout.Row = 1;
            app.UIAxesLeft_Castor.Layout.Column = 1;

            % Create ResultEvaluationPanel_41
            app.ResultEvaluationPanel_41 = uipanel(app.GridLayout_41);
            app.ResultEvaluationPanel_41.BorderType = 'none';
            app.ResultEvaluationPanel_41.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_41.Layout.Row = 2;
            app.ResultEvaluationPanel_41.Layout.Column = 1;

            % Create BewertungDropDown_41
            app.BewertungDropDown_41 = uidropdown(app.ResultEvaluationPanel_41);
            app.BewertungDropDown_41.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_41.Position = [5 57 326 22];
            app.BewertungDropDown_41.Value = 'The current results need further optimization.';

            % Create Lamp_41
            app.Lamp_41 = uilamp(app.ResultEvaluationPanel_41);
            app.Lamp_41.Position = [336 58 20 20];
            app.Lamp_41.Color = [1 1 0];

            % Create TextArea_42
            app.TextArea_42 = uitextarea(app.ResultEvaluationPanel_41);
            app.TextArea_42.Position = [5 3 352 50];

            % Create InfoPanel_41
            app.InfoPanel_41 = uipanel(app.GridLayout_41);
            app.InfoPanel_41.BorderType = 'none';
            app.InfoPanel_41.Title = 'Info.';
            app.InfoPanel_41.Layout.Row = 2;
            app.InfoPanel_41.Layout.Column = 2;

            % Create DatePicker_42
            app.DatePicker_42 = uidatepicker(app.InfoPanel_41);
            app.DatePicker_42.Position = [241 59 112 18];
            app.DatePicker_42.Value = datetime([2025 1 1]);

            % Create ProjectEditField_42Label
            app.ProjectEditField_42Label = uilabel(app.InfoPanel_41);
            app.ProjectEditField_42Label.HorizontalAlignment = 'right';
            app.ProjectEditField_42Label.Position = [4 57 46 22];
            app.ProjectEditField_42Label.Text = 'Project:';

            % Create ProjectEditField_42
            app.ProjectEditField_42 = uieditfield(app.InfoPanel_41, 'text');
            app.ProjectEditField_42.Position = [63 59 137 18];
            app.ProjectEditField_42.Value = 'Gestamp NRAC';

            % Create VersionEditField_41Label
            app.VersionEditField_41Label = uilabel(app.InfoPanel_41);
            app.VersionEditField_41Label.HorizontalAlignment = 'right';
            app.VersionEditField_41Label.Position = [4 31 48 22];
            app.VersionEditField_41Label.Text = 'Version:';

            % Create VersionEditField_41
            app.VersionEditField_41 = uieditfield(app.InfoPanel_41, 'text');
            app.VersionEditField_41.HorizontalAlignment = 'center';
            app.VersionEditField_41.Position = [63 34 77 17];
            app.VersionEditField_41.Value = 'G046';

            % Create FlexbodySwitch_41
            app.FlexbodySwitch_41 = uiswitch(app.InfoPanel_41, 'slider');
            app.FlexbodySwitch_41.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_41.FontSize = 9;
            app.FlexbodySwitch_41.Position = [219 34 35 16];
            app.FlexbodySwitch_41.Value = 'Flex-Off';

            % Create Image2_49
            app.Image2_49 = uiimage(app.InfoPanel_41);
            app.Image2_49.Position = [297 8 26 25];
            app.Image2_49.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_41Label
            app.CreatorDropDown_41Label = uilabel(app.InfoPanel_41);
            app.CreatorDropDown_41Label.FontSize = 8;
            app.CreatorDropDown_41Label.Position = [8 4 50 22];
            app.CreatorDropDown_41Label.Text = 'Creator:';

            % Create CreatorDropDown_41
            app.CreatorDropDown_41 = uidropdown(app.InfoPanel_41);
            app.CreatorDropDown_41.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_41.FontSize = 8;
            app.CreatorDropDown_41.Position = [63 7 100 16];
            app.CreatorDropDown_41.Value = 'Q. Rong';

            % Create Image9_42
            app.Image9_42 = uiimage(app.InfoPanel_41);
            app.Image9_42.Position = [328 4 30 28];
            app.Image9_42.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create SVSAAngleTab
            app.SVSAAngleTab = uitab(app.TabGroup_R_bump_results);
            app.SVSAAngleTab.Title = 'SVSA Angle';
            app.SVSAAngleTab.BackgroundColor = [1 1 1];

            % Create GridLayout_5
            app.GridLayout_5 = uigridlayout(app.SVSAAngleTab);
            app.GridLayout_5.ColumnWidth = {'5x', '5x'};
            app.GridLayout_5.RowHeight = {'24x', '8x'};
            app.GridLayout_5.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_swa
            app.UIAxesLeft_swa = uiaxes(app.GridLayout_5);
            title(app.UIAxesLeft_swa, 'Title')
            xlabel(app.UIAxesLeft_swa, 'X')
            ylabel(app.UIAxesLeft_swa, 'Y')
            zlabel(app.UIAxesLeft_swa, 'Z')
            app.UIAxesLeft_swa.FontName = 'Times New Roman';
            app.UIAxesLeft_swa.XLim = [-100 100];
            app.UIAxesLeft_swa.FontSize = 10;
            app.UIAxesLeft_swa.Layout.Row = 1;
            app.UIAxesLeft_swa.Layout.Column = 1;

            % Create UIAxesRight_swa
            app.UIAxesRight_swa = uiaxes(app.GridLayout_5);
            title(app.UIAxesRight_swa, 'Title')
            xlabel(app.UIAxesRight_swa, 'X')
            ylabel(app.UIAxesRight_swa, 'Y')
            zlabel(app.UIAxesRight_swa, 'Z')
            app.UIAxesRight_swa.FontName = 'Times New Roman';
            app.UIAxesRight_swa.XLim = [-100 100];
            app.UIAxesRight_swa.FontSize = 10;
            app.UIAxesRight_swa.Layout.Row = 1;
            app.UIAxesRight_swa.Layout.Column = 2;

            % Create ResultEvaluationPanel_5
            app.ResultEvaluationPanel_5 = uipanel(app.GridLayout_5);
            app.ResultEvaluationPanel_5.BorderType = 'none';
            app.ResultEvaluationPanel_5.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_5.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_5.Layout.Row = 2;
            app.ResultEvaluationPanel_5.Layout.Column = 1;
            app.ResultEvaluationPanel_5.FontWeight = 'bold';

            % Create BewertungDropDown_5
            app.BewertungDropDown_5 = uidropdown(app.ResultEvaluationPanel_5);
            app.BewertungDropDown_5.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_5.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_5ValueChanged, true);
            app.BewertungDropDown_5.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_5.Position = [5 57 326 22];
            app.BewertungDropDown_5.Value = 'The current results need further optimization.';

            % Create Lamp_5
            app.Lamp_5 = uilamp(app.ResultEvaluationPanel_5);
            app.Lamp_5.Position = [336 58 20 20];
            app.Lamp_5.Color = [1 1 0];

            % Create TextArea_5
            app.TextArea_5 = uitextarea(app.ResultEvaluationPanel_5);
            app.TextArea_5.Position = [5 3 352 50];

            % Create InfoPanel_6
            app.InfoPanel_6 = uipanel(app.GridLayout_5);
            app.InfoPanel_6.BorderType = 'none';
            app.InfoPanel_6.Title = 'Info.';
            app.InfoPanel_6.BackgroundColor = [1 1 1];
            app.InfoPanel_6.Layout.Row = 2;
            app.InfoPanel_6.Layout.Column = 2;
            app.InfoPanel_6.FontWeight = 'bold';

            % Create DatePicker_6
            app.DatePicker_6 = uidatepicker(app.InfoPanel_6);
            app.DatePicker_6.Position = [241 59 112 18];
            app.DatePicker_6.Value = datetime([2025 1 1]);

            % Create ProjectEditField_6Label
            app.ProjectEditField_6Label = uilabel(app.InfoPanel_6);
            app.ProjectEditField_6Label.HorizontalAlignment = 'right';
            app.ProjectEditField_6Label.Position = [4 57 46 22];
            app.ProjectEditField_6Label.Text = 'Project:';

            % Create ProjectEditField_6
            app.ProjectEditField_6 = uieditfield(app.InfoPanel_6, 'text');
            app.ProjectEditField_6.Position = [63 59 137 18];
            app.ProjectEditField_6.Value = 'Gestamp NRAC';

            % Create VersionEditField_6Label
            app.VersionEditField_6Label = uilabel(app.InfoPanel_6);
            app.VersionEditField_6Label.BackgroundColor = [1 1 1];
            app.VersionEditField_6Label.HorizontalAlignment = 'right';
            app.VersionEditField_6Label.Position = [4 31 48 22];
            app.VersionEditField_6Label.Text = 'Version:';

            % Create VersionEditField_6
            app.VersionEditField_6 = uieditfield(app.InfoPanel_6, 'text');
            app.VersionEditField_6.HorizontalAlignment = 'center';
            app.VersionEditField_6.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_6.Position = [63 34 77 17];
            app.VersionEditField_6.Value = 'G046';

            % Create FlexbodySwitch_6
            app.FlexbodySwitch_6 = uiswitch(app.InfoPanel_6, 'slider');
            app.FlexbodySwitch_6.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_6.FontSize = 9;
            app.FlexbodySwitch_6.Position = [219 34 35 16];
            app.FlexbodySwitch_6.Value = 'Flex-Off';

            % Create CreatorDropDown_6Label
            app.CreatorDropDown_6Label = uilabel(app.InfoPanel_6);
            app.CreatorDropDown_6Label.FontSize = 8;
            app.CreatorDropDown_6Label.Position = [8 4 50 22];
            app.CreatorDropDown_6Label.Text = 'Creator:';

            % Create CreatorDropDown_6
            app.CreatorDropDown_6 = uidropdown(app.InfoPanel_6);
            app.CreatorDropDown_6.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_6.FontSize = 8;
            app.CreatorDropDown_6.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_6.Position = [63 7 100 16];
            app.CreatorDropDown_6.Value = 'Q. Rong';

            % Create Image2_9
            app.Image2_9 = uiimage(app.InfoPanel_6);
            app.Image2_9.Position = [297 8 26 25];
            app.Image2_9.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_2
            app.Image9_2 = uiimage(app.InfoPanel_6);
            app.Image9_2.Position = [328 4 30 28];
            app.Image9_2.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create SVSALengthTab
            app.SVSALengthTab = uitab(app.TabGroup_R_bump_results);
            app.SVSALengthTab.Title = 'SVSA Length';
            app.SVSALengthTab.BackgroundColor = [1 1 1];

            % Create GridLayout_6
            app.GridLayout_6 = uigridlayout(app.SVSALengthTab);
            app.GridLayout_6.ColumnWidth = {'5x', '5x'};
            app.GridLayout_6.RowHeight = {'24x', '8x'};
            app.GridLayout_6.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_swl
            app.UIAxesLeft_swl = uiaxes(app.GridLayout_6);
            title(app.UIAxesLeft_swl, 'Title')
            xlabel(app.UIAxesLeft_swl, 'X')
            ylabel(app.UIAxesLeft_swl, 'Y')
            zlabel(app.UIAxesLeft_swl, 'Z')
            app.UIAxesLeft_swl.FontName = 'Times New Roman';
            app.UIAxesLeft_swl.XLim = [-100 100];
            app.UIAxesLeft_swl.FontSize = 10;
            app.UIAxesLeft_swl.Layout.Row = 1;
            app.UIAxesLeft_swl.Layout.Column = 1;

            % Create UIAxesRight_swl
            app.UIAxesRight_swl = uiaxes(app.GridLayout_6);
            title(app.UIAxesRight_swl, 'Title')
            xlabel(app.UIAxesRight_swl, 'X')
            ylabel(app.UIAxesRight_swl, 'Y')
            zlabel(app.UIAxesRight_swl, 'Z')
            app.UIAxesRight_swl.FontName = 'Times New Roman';
            app.UIAxesRight_swl.XLim = [-100 100];
            app.UIAxesRight_swl.FontSize = 10;
            app.UIAxesRight_swl.Layout.Row = 1;
            app.UIAxesRight_swl.Layout.Column = 2;

            % Create ResultEvaluationPanel_6
            app.ResultEvaluationPanel_6 = uipanel(app.GridLayout_6);
            app.ResultEvaluationPanel_6.BorderType = 'none';
            app.ResultEvaluationPanel_6.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_6.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_6.Layout.Row = 2;
            app.ResultEvaluationPanel_6.Layout.Column = 1;
            app.ResultEvaluationPanel_6.FontWeight = 'bold';

            % Create BewertungDropDown_6
            app.BewertungDropDown_6 = uidropdown(app.ResultEvaluationPanel_6);
            app.BewertungDropDown_6.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_6.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_6ValueChanged, true);
            app.BewertungDropDown_6.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_6.Position = [5 57 326 22];
            app.BewertungDropDown_6.Value = 'The current results need further optimization.';

            % Create Lamp_6
            app.Lamp_6 = uilamp(app.ResultEvaluationPanel_6);
            app.Lamp_6.Position = [336 58 20 20];
            app.Lamp_6.Color = [1 1 0];

            % Create TextArea_6
            app.TextArea_6 = uitextarea(app.ResultEvaluationPanel_6);
            app.TextArea_6.Position = [5 3 352 50];

            % Create InfoPanel_7
            app.InfoPanel_7 = uipanel(app.GridLayout_6);
            app.InfoPanel_7.BorderType = 'none';
            app.InfoPanel_7.Title = 'Info.';
            app.InfoPanel_7.BackgroundColor = [1 1 1];
            app.InfoPanel_7.Layout.Row = 2;
            app.InfoPanel_7.Layout.Column = 2;
            app.InfoPanel_7.FontWeight = 'bold';

            % Create DatePicker_7
            app.DatePicker_7 = uidatepicker(app.InfoPanel_7);
            app.DatePicker_7.Position = [241 59 112 18];
            app.DatePicker_7.Value = datetime([2025 1 1]);

            % Create ProjectEditField_7Label
            app.ProjectEditField_7Label = uilabel(app.InfoPanel_7);
            app.ProjectEditField_7Label.HorizontalAlignment = 'right';
            app.ProjectEditField_7Label.Position = [4 57 46 22];
            app.ProjectEditField_7Label.Text = 'Project:';

            % Create ProjectEditField_7
            app.ProjectEditField_7 = uieditfield(app.InfoPanel_7, 'text');
            app.ProjectEditField_7.Position = [63 59 137 18];
            app.ProjectEditField_7.Value = 'Gestamp NRAC';

            % Create VersionEditField_7Label
            app.VersionEditField_7Label = uilabel(app.InfoPanel_7);
            app.VersionEditField_7Label.BackgroundColor = [1 1 1];
            app.VersionEditField_7Label.HorizontalAlignment = 'right';
            app.VersionEditField_7Label.Position = [4 31 48 22];
            app.VersionEditField_7Label.Text = 'Version:';

            % Create VersionEditField_7
            app.VersionEditField_7 = uieditfield(app.InfoPanel_7, 'text');
            app.VersionEditField_7.HorizontalAlignment = 'center';
            app.VersionEditField_7.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_7.Position = [63 34 77 17];
            app.VersionEditField_7.Value = 'G046';

            % Create FlexbodySwitch_7
            app.FlexbodySwitch_7 = uiswitch(app.InfoPanel_7, 'slider');
            app.FlexbodySwitch_7.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_7.FontSize = 9;
            app.FlexbodySwitch_7.Position = [219 34 35 16];
            app.FlexbodySwitch_7.Value = 'Flex-Off';

            % Create Image2_7
            app.Image2_7 = uiimage(app.InfoPanel_7);
            app.Image2_7.Position = [297 8 26 25];
            app.Image2_7.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_7Label
            app.CreatorDropDown_7Label = uilabel(app.InfoPanel_7);
            app.CreatorDropDown_7Label.FontSize = 8;
            app.CreatorDropDown_7Label.Position = [8 4 50 22];
            app.CreatorDropDown_7Label.Text = 'Creator:';

            % Create CreatorDropDown_7
            app.CreatorDropDown_7 = uidropdown(app.InfoPanel_7);
            app.CreatorDropDown_7.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_7.FontSize = 8;
            app.CreatorDropDown_7.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_7.Position = [63 7 100 16];
            app.CreatorDropDown_7.Value = 'Q. Rong';

            % Create Image9
            app.Image9 = uiimage(app.InfoPanel_7);
            app.Image9.Position = [328 4 30 28];
            app.Image9.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create ResultsPanel_R_bump
            app.ResultsPanel_R_bump = uipanel(app.Tab_KcRear_Bump);
            app.ResultsPanel_R_bump.BorderWidth = 0.5;
            app.ResultsPanel_R_bump.Title = 'Results';
            app.ResultsPanel_R_bump.BackgroundColor = [1 1 1];
            app.ResultsPanel_R_bump.FontName = 'Times New Roman';
            app.ResultsPanel_R_bump.Position = [19 12 275 467];

            % Create GridLayout4
            app.GridLayout4 = uigridlayout(app.ResultsPanel_R_bump);
            app.GridLayout4.ColumnWidth = {78, 43, 76, 36};
            app.GridLayout4.RowHeight = {22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23};
            app.GridLayout4.ColumnSpacing = 8;
            app.GridLayout4.RowSpacing = 7.15625;
            app.GridLayout4.Padding = [8 7.15625 8 7.15625];
            app.GridLayout4.BackgroundColor = [1 1 1];

            % Create NmmLabel
            app.NmmLabel = uilabel(app.GridLayout4);
            app.NmmLabel.FontName = 'Times New Roman';
            app.NmmLabel.Layout.Row = 2;
            app.NmmLabel.Layout.Column = 2;
            app.NmmLabel.Text = 'N/mm';

            % Create NmmmmLabel
            app.NmmmmLabel = uilabel(app.GridLayout4);
            app.NmmmmLabel.FontName = 'Times New Roman';
            app.NmmmmLabel.Layout.Row = 2;
            app.NmmmmLabel.Layout.Column = 4;
            app.NmmmmLabel.Text = 'N/mm/mm';

            % Create degmLabel
            app.degmLabel = uilabel(app.GridLayout4);
            app.degmLabel.FontName = 'Times New Roman';
            app.degmLabel.Layout.Row = 4;
            app.degmLabel.Layout.Column = 2;
            app.degmLabel.Text = 'deg/m';

            % Create mmmLabel
            app.mmmLabel = uilabel(app.GridLayout4);
            app.mmmLabel.FontName = 'Times New Roman';
            app.mmmLabel.Layout.Row = 6;
            app.mmmLabel.Layout.Column = 2;
            app.mmmLabel.Text = 'mm/m';

            % Create degmLabel_2
            app.degmLabel_2 = uilabel(app.GridLayout4);
            app.degmLabel_2.FontName = 'Times New Roman';
            app.degmLabel_2.Layout.Row = 4;
            app.degmLabel_2.Layout.Column = 4;
            app.degmLabel_2.Text = 'deg/m';

            % Create mmmLabel_2
            app.mmmLabel_2 = uilabel(app.GridLayout4);
            app.mmmLabel_2.FontName = 'Times New Roman';
            app.mmmLabel_2.Layout.Row = 6;
            app.mmmLabel_2.Layout.Column = 4;
            app.mmmLabel_2.Text = 'mm/m';

            % Create HzLabel
            app.HzLabel = uilabel(app.GridLayout4);
            app.HzLabel.FontName = 'Times New Roman';
            app.HzLabel.Layout.Row = 8;
            app.HzLabel.Layout.Column = 4;
            app.HzLabel.Text = 'Hz';

            % Create degLabel_2
            app.degLabel_2 = uilabel(app.GridLayout4);
            app.degLabel_2.FontName = 'Times New Roman';
            app.degLabel_2.Layout.Row = 10;
            app.degLabel_2.Layout.Column = 4;
            app.degLabel_2.Text = 'deg';

            % Create degLabel_4
            app.degLabel_4 = uilabel(app.GridLayout4);
            app.degLabel_4.FontName = 'Times New Roman';
            app.degLabel_4.Layout.Row = 8;
            app.degLabel_4.Layout.Column = 2;
            app.degLabel_4.Text = 'deg';

            % Create degLabel
            app.degLabel = uilabel(app.GridLayout4);
            app.degLabel.FontName = 'Times New Roman';
            app.degLabel.Layout.Row = 10;
            app.degLabel.Layout.Column = 2;
            app.degLabel.Text = 'deg';

            % Create mmLabel
            app.mmLabel = uilabel(app.GridLayout4);
            app.mmLabel.FontName = 'Times New Roman';
            app.mmLabel.Layout.Row = 12;
            app.mmLabel.Layout.Column = 2;
            app.mmLabel.Text = 'mm';

            % Create degLabel_3
            app.degLabel_3 = uilabel(app.GridLayout4);
            app.degLabel_3.FontName = 'Times New Roman';
            app.degLabel_3.Layout.Row = 14;
            app.degLabel_3.Layout.Column = 2;
            app.degLabel_3.Text = 'deg';

            % Create NmmLabel_13
            app.NmmLabel_13 = uilabel(app.GridLayout4);
            app.NmmLabel_13.FontName = 'Times New Roman';
            app.NmmLabel_13.Layout.Row = 12;
            app.NmmLabel_13.Layout.Column = 4;
            app.NmmLabel_13.Text = 'N/mm';

            % Create mmLabel_2
            app.mmLabel_2 = uilabel(app.GridLayout4);
            app.mmLabel_2.FontName = 'Times New Roman';
            app.mmLabel_2.Layout.Row = 14;
            app.mmLabel_2.Layout.Column = 4;
            app.mmLabel_2.Text = 'mm';

            % Create BumpClearAxesButton
            app.BumpClearAxesButton = uibutton(app.GridLayout4, 'push');
            app.BumpClearAxesButton.ButtonPushedFcn = createCallbackFcn(app, @BumpClearAxesButtonPushed, true);
            app.BumpClearAxesButton.Layout.Row = 15;
            app.BumpClearAxesButton.Layout.Column = [3 4];
            app.BumpClearAxesButton.Text = 'Plot Clear';

            % Create PositivDirectionButton
            app.PositivDirectionButton = uibutton(app.GridLayout4, 'push');
            app.PositivDirectionButton.Layout.Row = 15;
            app.PositivDirectionButton.Layout.Column = [1 2];
            app.PositivDirectionButton.Text = 'Positiv Direction';

            % Create WheelRateWCEditFieldLabel
            app.WheelRateWCEditFieldLabel = uilabel(app.GridLayout4);
            app.WheelRateWCEditFieldLabel.FontName = 'Times New Roman';
            app.WheelRateWCEditFieldLabel.Layout.Row = 1;
            app.WheelRateWCEditFieldLabel.Layout.Column = [1 2];
            app.WheelRateWCEditFieldLabel.Text = 'Wheel Rate@WC';

            % Create WheelRateWCEditField
            app.WheelRateWCEditField = uieditfield(app.GridLayout4, 'numeric');
            app.WheelRateWCEditField.Layout.Row = 2;
            app.WheelRateWCEditField.Layout.Column = 1;

            % Create BumpSteerEditFieldLabel
            app.BumpSteerEditFieldLabel = uilabel(app.GridLayout4);
            app.BumpSteerEditFieldLabel.FontName = 'Times New Roman';
            app.BumpSteerEditFieldLabel.Layout.Row = 3;
            app.BumpSteerEditFieldLabel.Layout.Column = 1;
            app.BumpSteerEditFieldLabel.Text = 'Bump Steer';

            % Create BumpSteerEditField
            app.BumpSteerEditField = uieditfield(app.GridLayout4, 'numeric');
            app.BumpSteerEditField.Layout.Row = 4;
            app.BumpSteerEditField.Layout.Column = 1;

            % Create WheelRecessionEditFieldLabel
            app.WheelRecessionEditFieldLabel = uilabel(app.GridLayout4);
            app.WheelRecessionEditFieldLabel.FontName = 'Times New Roman';
            app.WheelRecessionEditFieldLabel.Layout.Row = 5;
            app.WheelRecessionEditFieldLabel.Layout.Column = [1 2];
            app.WheelRecessionEditFieldLabel.Text = 'Wheel Recession';

            % Create WheelRecessionEditField
            app.WheelRecessionEditField = uieditfield(app.GridLayout4, 'numeric');
            app.WheelRecessionEditField.Layout.Row = 6;
            app.WheelRecessionEditField.Layout.Column = 1;

            % Create SpringAngleEditFieldLabel
            app.SpringAngleEditFieldLabel = uilabel(app.GridLayout4);
            app.SpringAngleEditFieldLabel.FontName = 'Times New Roman';
            app.SpringAngleEditFieldLabel.Layout.Row = 7;
            app.SpringAngleEditFieldLabel.Layout.Column = 1;
            app.SpringAngleEditFieldLabel.Text = 'Spring Angle ';

            % Create SpringAngleEditField
            app.SpringAngleEditField = uieditfield(app.GridLayout4, 'numeric');
            app.SpringAngleEditField.Layout.Row = 8;
            app.SpringAngleEditField.Layout.Column = 1;

            % Create ToeCha50mmEditFieldLabel
            app.ToeCha50mmEditFieldLabel = uilabel(app.GridLayout4);
            app.ToeCha50mmEditFieldLabel.FontName = 'Times New Roman';
            app.ToeCha50mmEditFieldLabel.Layout.Row = 9;
            app.ToeCha50mmEditFieldLabel.Layout.Column = [1 2];
            app.ToeCha50mmEditFieldLabel.Text = 'Toe Cha. (+50mm)';

            % Create ToeCha50mmEditField
            app.ToeCha50mmEditField = uieditfield(app.GridLayout4, 'numeric');
            app.ToeCha50mmEditField.Layout.Row = 10;
            app.ToeCha50mmEditField.Layout.Column = 1;

            % Create WheelTravel2gHLEditFieldLabel
            app.WheelTravel2gHLEditFieldLabel = uilabel(app.GridLayout4);
            app.WheelTravel2gHLEditFieldLabel.FontName = 'Times New Roman';
            app.WheelTravel2gHLEditFieldLabel.Layout.Row = 11;
            app.WheelTravel2gHLEditFieldLabel.Layout.Column = [1 2];
            app.WheelTravel2gHLEditFieldLabel.Text = 'Wheel Travel (2g HL)';

            % Create WheelTravel2gHLEditField
            app.WheelTravel2gHLEditField = uieditfield(app.GridLayout4, 'numeric');
            app.WheelTravel2gHLEditField.Layout.Row = 12;
            app.WheelTravel2gHLEditField.Layout.Column = 1;

            % Create SVSAAngleEditFieldLabel
            app.SVSAAngleEditFieldLabel = uilabel(app.GridLayout4);
            app.SVSAAngleEditFieldLabel.FontName = 'Times New Roman';
            app.SVSAAngleEditFieldLabel.FontColor = [0 0 1];
            app.SVSAAngleEditFieldLabel.Layout.Row = 13;
            app.SVSAAngleEditFieldLabel.Layout.Column = 1;
            app.SVSAAngleEditFieldLabel.Text = 'SVSA Angle';

            % Create SVSAAngleEditField
            app.SVSAAngleEditField = uieditfield(app.GridLayout4, 'numeric');
            app.SVSAAngleEditField.Layout.Row = 14;
            app.SVSAAngleEditField.Layout.Column = 1;

            % Create WheelRateSlopeWCEditFieldLabel
            app.WheelRateSlopeWCEditFieldLabel = uilabel(app.GridLayout4);
            app.WheelRateSlopeWCEditFieldLabel.FontName = 'Times New Roman';
            app.WheelRateSlopeWCEditFieldLabel.Layout.Row = 1;
            app.WheelRateSlopeWCEditFieldLabel.Layout.Column = [3 4];
            app.WheelRateSlopeWCEditFieldLabel.Text = 'Wheel Rate Slope@WC';

            % Create WheelRateSlopeWCEditField
            app.WheelRateSlopeWCEditField = uieditfield(app.GridLayout4, 'numeric');
            app.WheelRateSlopeWCEditField.Layout.Row = 2;
            app.WheelRateSlopeWCEditField.Layout.Column = 3;

            % Create BumpCamberEditFieldLabel
            app.BumpCamberEditFieldLabel = uilabel(app.GridLayout4);
            app.BumpCamberEditFieldLabel.FontName = 'Times New Roman';
            app.BumpCamberEditFieldLabel.Layout.Row = 3;
            app.BumpCamberEditFieldLabel.Layout.Column = 3;
            app.BumpCamberEditFieldLabel.Text = 'Bump Camber';

            % Create BumpCamberEditField
            app.BumpCamberEditField = uieditfield(app.GridLayout4, 'numeric');
            app.BumpCamberEditField.Layout.Row = 4;
            app.BumpCamberEditField.Layout.Column = 3;

            % Create TrackChangeEditFieldLabel
            app.TrackChangeEditFieldLabel = uilabel(app.GridLayout4);
            app.TrackChangeEditFieldLabel.FontName = 'Times New Roman';
            app.TrackChangeEditFieldLabel.Layout.Row = 5;
            app.TrackChangeEditFieldLabel.Layout.Column = 3;
            app.TrackChangeEditFieldLabel.Text = 'Track Change';

            % Create TrackChangeEditField
            app.TrackChangeEditField = uieditfield(app.GridLayout4, 'numeric');
            app.TrackChangeEditField.Layout.Row = 6;
            app.TrackChangeEditField.Layout.Column = 3;

            % Create SuspensionFreqEditFieldLabel
            app.SuspensionFreqEditFieldLabel = uilabel(app.GridLayout4);
            app.SuspensionFreqEditFieldLabel.FontName = 'Times New Roman';
            app.SuspensionFreqEditFieldLabel.Layout.Row = 7;
            app.SuspensionFreqEditFieldLabel.Layout.Column = [3 4];
            app.SuspensionFreqEditFieldLabel.Text = 'Suspension Freq.';

            % Create SuspensionFreqEditField
            app.SuspensionFreqEditField = uieditfield(app.GridLayout4, 'numeric');
            app.SuspensionFreqEditField.Layout.Row = 8;
            app.SuspensionFreqEditField.Layout.Column = 3;

            % Create ToeCha50mmLabel
            app.ToeCha50mmLabel = uilabel(app.GridLayout4);
            app.ToeCha50mmLabel.FontName = 'Times New Roman';
            app.ToeCha50mmLabel.Layout.Row = 9;
            app.ToeCha50mmLabel.Layout.Column = [3 4];
            app.ToeCha50mmLabel.Text = 'Toe Cha. (-50mm)';

            % Create ToeCha50mmEditField_2
            app.ToeCha50mmEditField_2 = uieditfield(app.GridLayout4, 'numeric');
            app.ToeCha50mmEditField_2.Layout.Row = 10;
            app.ToeCha50mmEditField_2.Layout.Column = 3;

            % Create WheelRate2gHLEditFieldLabel
            app.WheelRate2gHLEditFieldLabel = uilabel(app.GridLayout4);
            app.WheelRate2gHLEditFieldLabel.FontName = 'Times New Roman';
            app.WheelRate2gHLEditFieldLabel.Layout.Row = 11;
            app.WheelRate2gHLEditFieldLabel.Layout.Column = [3 4];
            app.WheelRate2gHLEditFieldLabel.Text = 'Wheel Rate (2g HL)';

            % Create WheelRate2gHLEditField
            app.WheelRate2gHLEditField = uieditfield(app.GridLayout4, 'numeric');
            app.WheelRate2gHLEditField.Layout.Row = 12;
            app.WheelRate2gHLEditField.Layout.Column = 3;

            % Create SVSALengthEditFieldLabel
            app.SVSALengthEditFieldLabel = uilabel(app.GridLayout4);
            app.SVSALengthEditFieldLabel.FontName = 'Times New Roman';
            app.SVSALengthEditFieldLabel.FontColor = [0 0 1];
            app.SVSALengthEditFieldLabel.Layout.Row = 13;
            app.SVSALengthEditFieldLabel.Layout.Column = 3;
            app.SVSALengthEditFieldLabel.Text = 'SVSA Length';

            % Create SVSALengthEditField
            app.SVSALengthEditField = uieditfield(app.GridLayout4, 'numeric');
            app.SVSALengthEditField.Layout.Row = 14;
            app.SVSALengthEditField.Layout.Column = 3;

            % Create GOButton_bump
            app.GOButton_bump = uibutton(app.Tab_KcRear_Bump, 'push');
            app.GOButton_bump.ButtonPushedFcn = createCallbackFcn(app, @GOButton_bumpPushed, true);
            app.GOButton_bump.Tag = 'executeFunctionButton';
            app.GOButton_bump.Position = [740 500 100 23];
            app.GOButton_bump.Text = 'GO!';

            % Create EditField_browser_bump
            app.EditField_browser_bump = uieditfield(app.Tab_KcRear_Bump, 'text');
            app.EditField_browser_bump.Tag = 'filePathEditField';
            app.EditField_browser_bump.Position = [209 500 512 22];

            % Create Button_browser_bump
            app.Button_browser_bump = uibutton(app.Tab_KcRear_Bump, 'push');
            app.Button_browser_bump.ButtonPushedFcn = createCallbackFcn(app, @Button_browser_bumpPushed, true);
            app.Button_browser_bump.Tag = 'selectFileButton';
            app.Button_browser_bump.Position = [19 500 100 23];
            app.Button_browser_bump.Text = 'Select File ...';

            % Create BYDDelphinButton
            app.BYDDelphinButton = uibutton(app.Tab_KcRear_Bump, 'state');
            app.BYDDelphinButton.Text = 'BYD Delphin';
            app.BYDDelphinButton.BackgroundColor = [0.9412 0.9412 0.9412];
            app.BYDDelphinButton.Position = [1075 430 88 23];

            % Create VWPassatButton
            app.VWPassatButton = uibutton(app.Tab_KcRear_Bump, 'state');
            app.VWPassatButton.Text = 'VW Passat';
            app.VWPassatButton.Position = [1075 404 88 23];

            % Create TeslaModel3Button
            app.TeslaModel3Button = uibutton(app.Tab_KcRear_Bump, 'state');
            app.TeslaModel3Button.Text = 'Tesla Model 3';
            app.TeslaModel3Button.Position = [1075 293 89 23];

            % Create FORDEDGEButton
            app.FORDEDGEButton = uibutton(app.Tab_KcRear_Bump, 'state');
            app.FORDEDGEButton.Text = 'FORD EDGE';
            app.FORDEDGEButton.Position = [1075 378 88 23];

            % Create RefVehicleLabel
            app.RefVehicleLabel = uilabel(app.Tab_KcRear_Bump);
            app.RefVehicleLabel.FontWeight = 'bold';
            app.RefVehicleLabel.Position = [1081 510 72 22];
            app.RefVehicleLabel.Text = 'Ref. Vehicle';

            % Create ABDSPMMPlusLabel
            app.ABDSPMMPlusLabel = uilabel(app.Tab_KcRear_Bump);
            app.ABDSPMMPlusLabel.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel.FontSize = 10;
            app.ABDSPMMPlusLabel.FontAngle = 'italic';
            app.ABDSPMMPlusLabel.Position = [1069 480 108 22];
            app.ABDSPMMPlusLabel.Text = '* ABD SPMM Plus';

            % Create TestBenchResultsLabel
            app.TestBenchResultsLabel = uilabel(app.Tab_KcRear_Bump);
            app.TestBenchResultsLabel.FontName = 'Times New Roman';
            app.TestBenchResultsLabel.FontSize = 10;
            app.TestBenchResultsLabel.FontAngle = 'italic';
            app.TestBenchResultsLabel.Position = [1069 459 108 22];
            app.TestBenchResultsLabel.Text = '   Test Bench Results';

            % Create ABDSPMMPlusLabel_2
            app.ABDSPMMPlusLabel_2 = uilabel(app.Tab_KcRear_Bump);
            app.ABDSPMMPlusLabel_2.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_2.FontSize = 10;
            app.ABDSPMMPlusLabel_2.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_2.Position = [1069 343 108 22];
            app.ABDSPMMPlusLabel_2.Text = '* ABD SPMM Plus';

            % Create TestReportLabel
            app.TestReportLabel = uilabel(app.Tab_KcRear_Bump);
            app.TestReportLabel.FontName = 'Times New Roman';
            app.TestReportLabel.FontSize = 10;
            app.TestReportLabel.FontAngle = 'italic';
            app.TestReportLabel.Position = [1069 322 108 22];
            app.TestReportLabel.Text = '   Test Report';

            % Create VWID3Button
            app.VWID3Button = uibutton(app.Tab_KcRear_Bump, 'state');
            app.VWID3Button.Text = 'VW ID.3';
            app.VWID3Button.Position = [1075 267 89 23];

            % Create BMW325iButton
            app.BMW325iButton = uibutton(app.Tab_KcRear_Bump, 'state');
            app.BMW325iButton.Text = 'BMW 325i';
            app.BMW325iButton.Position = [1075 241 89 23];

            % Create TOYOTAYarisButton
            app.TOYOTAYarisButton = uibutton(app.Tab_KcRear_Bump, 'state');
            app.TOYOTAYarisButton.Text = 'TOYOTA Yaris';
            app.TOYOTAYarisButton.Position = [1075 79 89 23];

            % Create BYDDolphinButton
            app.BYDDolphinButton = uibutton(app.Tab_KcRear_Bump, 'state');
            app.BYDDolphinButton.Text = 'BYD Dolphin';
            app.BYDDolphinButton.Position = [1075 157 89 23];

            % Create ABDSPMMPlusLabel_3
            app.ABDSPMMPlusLabel_3 = uilabel(app.Tab_KcRear_Bump);
            app.ABDSPMMPlusLabel_3.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_3.FontSize = 10;
            app.ABDSPMMPlusLabel_3.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_3.Position = [1069 207 108 22];
            app.ABDSPMMPlusLabel_3.Text = '* ABD SPMM Plus';

            % Create TwistBeamLabel
            app.TwistBeamLabel = uilabel(app.Tab_KcRear_Bump);
            app.TwistBeamLabel.FontName = 'Times New Roman';
            app.TwistBeamLabel.FontSize = 10;
            app.TwistBeamLabel.FontAngle = 'italic';
            app.TwistBeamLabel.Position = [1069 186 108 22];
            app.TwistBeamLabel.Text = '   TwistBeam';

            % Create VWGolfButton_2
            app.VWGolfButton_2 = uibutton(app.Tab_KcRear_Bump, 'state');
            app.VWGolfButton_2.Text = 'VW Golf';
            app.VWGolfButton_2.Position = [1075 131 89 23];

            % Create VWUPButton
            app.VWUPButton = uibutton(app.Tab_KcRear_Bump, 'state');
            app.VWUPButton.Text = 'VW UP!';
            app.VWUPButton.Position = [1075 105 89 23];

            % Create Button
            app.Button = uibutton(app.Tab_KcRear_Bump, 'push');
            app.Button.Icon = fullfile(pathToMLAPP, 'Icon_plot_custerm.png');
            app.Button.Position = [1075 11 40 41];
            app.Button.Text = '';

            % Create Button_2
            app.Button_2 = uibutton(app.Tab_KcRear_Bump, 'push');
            app.Button_2.Icon = fullfile(pathToMLAPP, 'icon_to_ppt.png');
            app.Button_2.Position = [1127 12 37 40];
            app.Button_2.Text = '';

            % Create Tab_KcRear_Roll
            app.Tab_KcRear_Roll = uitab(app.Tab_KcRear);
            app.Tab_KcRear_Roll.Title = 'Roll Test';
            app.Tab_KcRear_Roll.BackgroundColor = [0.9412 0.9412 0.9412];

            % Create CurrentFileLabel
            app.CurrentFileLabel = uilabel(app.Tab_KcRear_Roll);
            app.CurrentFileLabel.HorizontalAlignment = 'right';
            app.CurrentFileLabel.Position = [124 500 70 22];
            app.CurrentFileLabel.Text = 'Current File:';

            % Create FittingRangeKnob_R_roll
            app.FittingRangeKnob_R_roll = uiknob(app.Tab_KcRear_Roll, 'discrete');
            app.FittingRangeKnob_R_roll.Items = {'0.1', '0.2', '0.5', '1', '2'};
            app.FittingRangeKnob_R_roll.ValueChangedFcn = createCallbackFcn(app, @FittingRangeKnob_R_rollValueChanged, true);
            app.FittingRangeKnob_R_roll.FontName = 'Times New Roman';
            app.FittingRangeKnob_R_roll.FontSize = 8;
            app.FittingRangeKnob_R_roll.Position = [1004 484 33 33];
            app.FittingRangeKnob_R_roll.Value = '1';

            % Create EditField_R_roll_range
            app.EditField_R_roll_range = uieditfield(app.Tab_KcRear_Roll, 'numeric');
            app.EditField_R_roll_range.ValueChangedFcn = createCallbackFcn(app, @EditField_R_roll_rangeValueChanged, true);
            app.EditField_R_roll_range.FontName = 'Times New Roman';
            app.EditField_R_roll_range.FontSize = 10;
            app.EditField_R_roll_range.Position = [871 491 46 18];
            app.EditField_R_roll_range.Value = 1;

            % Create mmLabel_R_roll_rangshow
            app.mmLabel_R_roll_rangshow = uilabel(app.Tab_KcRear_Roll);
            app.mmLabel_R_roll_rangshow.FontName = 'Times New Roman';
            app.mmLabel_R_roll_rangshow.Position = [918 489 39 22];
            app.mmLabel_R_roll_rangshow.Text = '* +/-1°';

            % Create TabGroup_R_roll_results
            app.TabGroup_R_roll_results = uitabgroup(app.Tab_KcRear_Roll);
            app.TabGroup_R_roll_results.Position = [304 10 756 468];

            % Create RollRateWCTab
            app.RollRateWCTab = uitab(app.TabGroup_R_roll_results);
            app.RollRateWCTab.Title = 'Roll Rate@WC';
            app.RollRateWCTab.BackgroundColor = [1 1 1];

            % Create GridLayout_9
            app.GridLayout_9 = uigridlayout(app.RollRateWCTab);
            app.GridLayout_9.ColumnWidth = {'5x', '5x'};
            app.GridLayout_9.RowHeight = {'24x', '8x'};
            app.GridLayout_9.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_R_Rollrate
            app.UIAxesLeft_R_R_Rollrate = uiaxes(app.GridLayout_9);
            title(app.UIAxesLeft_R_R_Rollrate, 'Title')
            xlabel(app.UIAxesLeft_R_R_Rollrate, 'X')
            ylabel(app.UIAxesLeft_R_R_Rollrate, 'Y')
            zlabel(app.UIAxesLeft_R_R_Rollrate, 'Z')
            app.UIAxesLeft_R_R_Rollrate.FontName = 'Times New Roman';
            app.UIAxesLeft_R_R_Rollrate.XLim = [-5 5];
            app.UIAxesLeft_R_R_Rollrate.XTick = [-5 -4 -3 -2 -1 0 1 2 3 4 5];
            app.UIAxesLeft_R_R_Rollrate.XTickLabel = {'-5'; '-4'; '-3'; '-2'; '-1'; '0'; '1'; '2'; '3'; '4'; '5'};
            app.UIAxesLeft_R_R_Rollrate.FontSize = 8;
            app.UIAxesLeft_R_R_Rollrate.Layout.Row = 1;
            app.UIAxesLeft_R_R_Rollrate.Layout.Column = 1;

            % Create UIAxesRight_R_R_Rollrate
            app.UIAxesRight_R_R_Rollrate = uiaxes(app.GridLayout_9);
            title(app.UIAxesRight_R_R_Rollrate, 'Title')
            xlabel(app.UIAxesRight_R_R_Rollrate, 'X')
            ylabel(app.UIAxesRight_R_R_Rollrate, 'Y')
            zlabel(app.UIAxesRight_R_R_Rollrate, 'Z')
            app.UIAxesRight_R_R_Rollrate.FontName = 'Times New Roman';
            app.UIAxesRight_R_R_Rollrate.XLim = [-5 5];
            app.UIAxesRight_R_R_Rollrate.FontSize = 8;
            app.UIAxesRight_R_R_Rollrate.Layout.Row = 1;
            app.UIAxesRight_R_R_Rollrate.Layout.Column = 2;

            % Create ResultEvaluationPanel_9
            app.ResultEvaluationPanel_9 = uipanel(app.GridLayout_9);
            app.ResultEvaluationPanel_9.BorderType = 'none';
            app.ResultEvaluationPanel_9.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_9.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_9.Layout.Row = 2;
            app.ResultEvaluationPanel_9.Layout.Column = 1;
            app.ResultEvaluationPanel_9.FontWeight = 'bold';

            % Create BewertungDropDown_9
            app.BewertungDropDown_9 = uidropdown(app.ResultEvaluationPanel_9);
            app.BewertungDropDown_9.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_9.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_9ValueChanged, true);
            app.BewertungDropDown_9.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_9.Position = [5 57 326 22];
            app.BewertungDropDown_9.Value = 'The current results need further optimization.';

            % Create Lamp_9
            app.Lamp_9 = uilamp(app.ResultEvaluationPanel_9);
            app.Lamp_9.Position = [336 58 20 20];
            app.Lamp_9.Color = [1 1 0.0667];

            % Create TextArea_9
            app.TextArea_9 = uitextarea(app.ResultEvaluationPanel_9);
            app.TextArea_9.Position = [5 3 352 50];

            % Create InfoPanel_9
            app.InfoPanel_9 = uipanel(app.GridLayout_9);
            app.InfoPanel_9.BorderType = 'none';
            app.InfoPanel_9.Title = 'Info.';
            app.InfoPanel_9.BackgroundColor = [1 1 1];
            app.InfoPanel_9.Layout.Row = 2;
            app.InfoPanel_9.Layout.Column = 2;
            app.InfoPanel_9.FontWeight = 'bold';

            % Create DatePicker_9
            app.DatePicker_9 = uidatepicker(app.InfoPanel_9);
            app.DatePicker_9.Position = [175 7 112 18];
            app.DatePicker_9.Value = datetime([2025 1 1]);

            % Create ProjectEditField_9Label
            app.ProjectEditField_9Label = uilabel(app.InfoPanel_9);
            app.ProjectEditField_9Label.HorizontalAlignment = 'right';
            app.ProjectEditField_9Label.Position = [4 57 46 22];
            app.ProjectEditField_9Label.Text = 'Project:';

            % Create ProjectEditField_9
            app.ProjectEditField_9 = uieditfield(app.InfoPanel_9, 'text');
            app.ProjectEditField_9.Position = [63 59 137 18];
            app.ProjectEditField_9.Value = 'Gestamp NRAC';

            % Create VersionEditField_9Label
            app.VersionEditField_9Label = uilabel(app.InfoPanel_9);
            app.VersionEditField_9Label.BackgroundColor = [1 1 1];
            app.VersionEditField_9Label.HorizontalAlignment = 'right';
            app.VersionEditField_9Label.Position = [4 31 48 22];
            app.VersionEditField_9Label.Text = 'Version:';

            % Create VersionEditField_9
            app.VersionEditField_9 = uieditfield(app.InfoPanel_9, 'text');
            app.VersionEditField_9.HorizontalAlignment = 'center';
            app.VersionEditField_9.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_9.Position = [63 34 77 17];
            app.VersionEditField_9.Value = 'G046';

            % Create FlexbodySwitch_9
            app.FlexbodySwitch_9 = uiswitch(app.InfoPanel_9, 'slider');
            app.FlexbodySwitch_9.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_9.FontSize = 9;
            app.FlexbodySwitch_9.Position = [219 34 35 16];
            app.FlexbodySwitch_9.Value = 'Flex-Off';

            % Create CreatorDropDown_9Label
            app.CreatorDropDown_9Label = uilabel(app.InfoPanel_9);
            app.CreatorDropDown_9Label.FontSize = 8;
            app.CreatorDropDown_9Label.Position = [8 4 50 22];
            app.CreatorDropDown_9Label.Text = 'Creator:';

            % Create CreatorDropDown_9
            app.CreatorDropDown_9 = uidropdown(app.InfoPanel_9);
            app.CreatorDropDown_9.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_9.FontSize = 8;
            app.CreatorDropDown_9.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_9.Position = [63 7 100 16];
            app.CreatorDropDown_9.Value = 'Q. Rong';

            % Create Image2_16
            app.Image2_16 = uiimage(app.InfoPanel_9);
            app.Image2_16.Position = [297 8 26 25];
            app.Image2_16.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_9
            app.Image9_9 = uiimage(app.InfoPanel_9);
            app.Image9_9.Position = [328 4 30 28];
            app.Image9_9.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create RollTestLabel_2
            app.RollTestLabel_2 = uilabel(app.InfoPanel_9);
            app.RollTestLabel_2.BackgroundColor = [0.9294 0.6941 0.1255];
            app.RollTestLabel_2.HorizontalAlignment = 'right';
            app.RollTestLabel_2.FontWeight = 'bold';
            app.RollTestLabel_2.Position = [219 59 139 18];
            app.RollTestLabel_2.Text = 'Roll Test';

            % Create RollSteerTab
            app.RollSteerTab = uitab(app.TabGroup_R_roll_results);
            app.RollSteerTab.Title = 'Roll Steer';
            app.RollSteerTab.BackgroundColor = [1 1 1];

            % Create GridLayout_11
            app.GridLayout_11 = uigridlayout(app.RollSteerTab);
            app.GridLayout_11.ColumnWidth = {'5x', '5x'};
            app.GridLayout_11.RowHeight = {'24x', '8x'};
            app.GridLayout_11.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_R_toe
            app.UIAxesLeft_R_R_toe = uiaxes(app.GridLayout_11);
            title(app.UIAxesLeft_R_R_toe, 'Title')
            xlabel(app.UIAxesLeft_R_R_toe, 'X')
            ylabel(app.UIAxesLeft_R_R_toe, 'Y')
            zlabel(app.UIAxesLeft_R_R_toe, 'Z')
            app.UIAxesLeft_R_R_toe.FontName = 'Times New Roman';
            app.UIAxesLeft_R_R_toe.XLim = [-5 5];
            app.UIAxesLeft_R_R_toe.FontSize = 8;
            app.UIAxesLeft_R_R_toe.Layout.Row = 1;
            app.UIAxesLeft_R_R_toe.Layout.Column = 1;

            % Create UIAxesRight_R_R_toe
            app.UIAxesRight_R_R_toe = uiaxes(app.GridLayout_11);
            title(app.UIAxesRight_R_R_toe, 'Title')
            xlabel(app.UIAxesRight_R_R_toe, 'X')
            ylabel(app.UIAxesRight_R_R_toe, 'Y')
            zlabel(app.UIAxesRight_R_R_toe, 'Z')
            app.UIAxesRight_R_R_toe.FontName = 'Times New Roman';
            app.UIAxesRight_R_R_toe.XLim = [-5 5];
            app.UIAxesRight_R_R_toe.FontSize = 8;
            app.UIAxesRight_R_R_toe.Layout.Row = 1;
            app.UIAxesRight_R_R_toe.Layout.Column = 2;

            % Create InfoPanel_11
            app.InfoPanel_11 = uipanel(app.GridLayout_11);
            app.InfoPanel_11.BorderType = 'none';
            app.InfoPanel_11.Title = 'Info.';
            app.InfoPanel_11.BackgroundColor = [1 1 1];
            app.InfoPanel_11.Layout.Row = 2;
            app.InfoPanel_11.Layout.Column = 2;
            app.InfoPanel_11.FontWeight = 'bold';

            % Create DatePicker_11
            app.DatePicker_11 = uidatepicker(app.InfoPanel_11);
            app.DatePicker_11.Position = [175 7 112 18];
            app.DatePicker_11.Value = datetime([2025 1 1]);

            % Create ProjectEditField_11Label
            app.ProjectEditField_11Label = uilabel(app.InfoPanel_11);
            app.ProjectEditField_11Label.HorizontalAlignment = 'right';
            app.ProjectEditField_11Label.Position = [4 58 46 22];
            app.ProjectEditField_11Label.Text = 'Project:';

            % Create ProjectEditField_11
            app.ProjectEditField_11 = uieditfield(app.InfoPanel_11, 'text');
            app.ProjectEditField_11.Position = [63 59 137 18];
            app.ProjectEditField_11.Value = 'Gestamp NRAC';

            % Create VersionEditField_11Label
            app.VersionEditField_11Label = uilabel(app.InfoPanel_11);
            app.VersionEditField_11Label.BackgroundColor = [1 1 1];
            app.VersionEditField_11Label.HorizontalAlignment = 'right';
            app.VersionEditField_11Label.Position = [4 32 48 22];
            app.VersionEditField_11Label.Text = 'Version:';

            % Create VersionEditField_11
            app.VersionEditField_11 = uieditfield(app.InfoPanel_11, 'text');
            app.VersionEditField_11.HorizontalAlignment = 'center';
            app.VersionEditField_11.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_11.Position = [63 34 77 17];
            app.VersionEditField_11.Value = 'G046';

            % Create FlexbodySwitch_11
            app.FlexbodySwitch_11 = uiswitch(app.InfoPanel_11, 'slider');
            app.FlexbodySwitch_11.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_11.FontSize = 9;
            app.FlexbodySwitch_11.Position = [219 34 35 16];
            app.FlexbodySwitch_11.Value = 'Flex-Off';

            % Create CreatorDropDown_11Label
            app.CreatorDropDown_11Label = uilabel(app.InfoPanel_11);
            app.CreatorDropDown_11Label.FontSize = 8;
            app.CreatorDropDown_11Label.Position = [8 5 50 22];
            app.CreatorDropDown_11Label.Text = 'Creator:';

            % Create CreatorDropDown_11
            app.CreatorDropDown_11 = uidropdown(app.InfoPanel_11);
            app.CreatorDropDown_11.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_11.FontSize = 8;
            app.CreatorDropDown_11.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_11.Position = [63 7 100 16];
            app.CreatorDropDown_11.Value = 'Q. Rong';

            % Create Image2_18
            app.Image2_18 = uiimage(app.InfoPanel_11);
            app.Image2_18.Position = [297 8 26 25];
            app.Image2_18.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_11
            app.Image9_11 = uiimage(app.InfoPanel_11);
            app.Image9_11.Position = [328 4 30 28];
            app.Image9_11.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create RollTestLabel
            app.RollTestLabel = uilabel(app.InfoPanel_11);
            app.RollTestLabel.BackgroundColor = [0.9294 0.6941 0.1255];
            app.RollTestLabel.HorizontalAlignment = 'right';
            app.RollTestLabel.FontWeight = 'bold';
            app.RollTestLabel.Position = [219 59 139 18];
            app.RollTestLabel.Text = 'Roll Test';

            % Create ResultEvaluationPanel_11
            app.ResultEvaluationPanel_11 = uipanel(app.GridLayout_11);
            app.ResultEvaluationPanel_11.BorderType = 'none';
            app.ResultEvaluationPanel_11.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_11.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_11.Layout.Row = 2;
            app.ResultEvaluationPanel_11.Layout.Column = 1;
            app.ResultEvaluationPanel_11.FontWeight = 'bold';

            % Create BewertungDropDown_11
            app.BewertungDropDown_11 = uidropdown(app.ResultEvaluationPanel_11);
            app.BewertungDropDown_11.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_11.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_11ValueChanged, true);
            app.BewertungDropDown_11.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_11.Position = [5 57 326 22];
            app.BewertungDropDown_11.Value = 'The current results need further optimization.';

            % Create Lamp_11
            app.Lamp_11 = uilamp(app.ResultEvaluationPanel_11);
            app.Lamp_11.Position = [336 58 20 20];
            app.Lamp_11.Color = [1 1 0.0667];

            % Create TextArea_11
            app.TextArea_11 = uitextarea(app.ResultEvaluationPanel_11);
            app.TextArea_11.Position = [5 3 352 50];

            % Create RollCamberTab
            app.RollCamberTab = uitab(app.TabGroup_R_roll_results);
            app.RollCamberTab.Title = 'Roll Camber';
            app.RollCamberTab.BackgroundColor = [1 1 1];

            % Create GridLayout_12
            app.GridLayout_12 = uigridlayout(app.RollCamberTab);
            app.GridLayout_12.ColumnWidth = {'5x', '5x'};
            app.GridLayout_12.RowHeight = {'24x', '8x'};
            app.GridLayout_12.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_R_camber
            app.UIAxesLeft_R_R_camber = uiaxes(app.GridLayout_12);
            title(app.UIAxesLeft_R_R_camber, 'Title')
            xlabel(app.UIAxesLeft_R_R_camber, 'X')
            ylabel(app.UIAxesLeft_R_R_camber, 'Y')
            zlabel(app.UIAxesLeft_R_R_camber, 'Z')
            app.UIAxesLeft_R_R_camber.FontName = 'Times New Roman';
            app.UIAxesLeft_R_R_camber.XLim = [-5 5];
            app.UIAxesLeft_R_R_camber.FontSize = 8;
            app.UIAxesLeft_R_R_camber.Layout.Row = 1;
            app.UIAxesLeft_R_R_camber.Layout.Column = 1;

            % Create UIAxesRight_R_R_camber
            app.UIAxesRight_R_R_camber = uiaxes(app.GridLayout_12);
            title(app.UIAxesRight_R_R_camber, 'Title')
            xlabel(app.UIAxesRight_R_R_camber, 'X')
            ylabel(app.UIAxesRight_R_R_camber, 'Y')
            zlabel(app.UIAxesRight_R_R_camber, 'Z')
            app.UIAxesRight_R_R_camber.FontName = 'Times New Roman';
            app.UIAxesRight_R_R_camber.XLim = [-5 5];
            app.UIAxesRight_R_R_camber.FontSize = 8;
            app.UIAxesRight_R_R_camber.Layout.Row = 1;
            app.UIAxesRight_R_R_camber.Layout.Column = 2;

            % Create ResultEvaluationPanel_12
            app.ResultEvaluationPanel_12 = uipanel(app.GridLayout_12);
            app.ResultEvaluationPanel_12.BorderType = 'none';
            app.ResultEvaluationPanel_12.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_12.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_12.Layout.Row = 2;
            app.ResultEvaluationPanel_12.Layout.Column = 1;
            app.ResultEvaluationPanel_12.FontWeight = 'bold';

            % Create BewertungDropDown_12
            app.BewertungDropDown_12 = uidropdown(app.ResultEvaluationPanel_12);
            app.BewertungDropDown_12.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_12.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_12ValueChanged, true);
            app.BewertungDropDown_12.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_12.Position = [5 57 326 22];
            app.BewertungDropDown_12.Value = 'The current results need further optimization.';

            % Create Lamp_12
            app.Lamp_12 = uilamp(app.ResultEvaluationPanel_12);
            app.Lamp_12.Position = [336 58 20 20];
            app.Lamp_12.Color = [1 1 0.0667];

            % Create TextArea_12
            app.TextArea_12 = uitextarea(app.ResultEvaluationPanel_12);
            app.TextArea_12.Position = [5 3 352 50];

            % Create InfoPanel_12
            app.InfoPanel_12 = uipanel(app.GridLayout_12);
            app.InfoPanel_12.BorderType = 'none';
            app.InfoPanel_12.Title = 'Info.';
            app.InfoPanel_12.BackgroundColor = [1 1 1];
            app.InfoPanel_12.Layout.Row = 2;
            app.InfoPanel_12.Layout.Column = 2;
            app.InfoPanel_12.FontWeight = 'bold';

            % Create DatePicker_12
            app.DatePicker_12 = uidatepicker(app.InfoPanel_12);
            app.DatePicker_12.Position = [175 7 112 18];
            app.DatePicker_12.Value = datetime([2025 1 1]);

            % Create ProjectEditField_12Label
            app.ProjectEditField_12Label = uilabel(app.InfoPanel_12);
            app.ProjectEditField_12Label.HorizontalAlignment = 'right';
            app.ProjectEditField_12Label.Position = [4 57 46 22];
            app.ProjectEditField_12Label.Text = 'Project:';

            % Create ProjectEditField_12
            app.ProjectEditField_12 = uieditfield(app.InfoPanel_12, 'text');
            app.ProjectEditField_12.Position = [63 59 137 18];
            app.ProjectEditField_12.Value = 'Gestamp NRAC';

            % Create VersionEditField_12Label
            app.VersionEditField_12Label = uilabel(app.InfoPanel_12);
            app.VersionEditField_12Label.BackgroundColor = [1 1 1];
            app.VersionEditField_12Label.HorizontalAlignment = 'right';
            app.VersionEditField_12Label.Position = [4 31 48 22];
            app.VersionEditField_12Label.Text = 'Version:';

            % Create VersionEditField_12
            app.VersionEditField_12 = uieditfield(app.InfoPanel_12, 'text');
            app.VersionEditField_12.HorizontalAlignment = 'center';
            app.VersionEditField_12.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_12.Position = [63 34 77 17];
            app.VersionEditField_12.Value = 'G046';

            % Create FlexbodySwitch_12
            app.FlexbodySwitch_12 = uiswitch(app.InfoPanel_12, 'slider');
            app.FlexbodySwitch_12.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_12.FontSize = 9;
            app.FlexbodySwitch_12.Position = [219 34 35 16];
            app.FlexbodySwitch_12.Value = 'Flex-Off';

            % Create CreatorDropDown_12Label
            app.CreatorDropDown_12Label = uilabel(app.InfoPanel_12);
            app.CreatorDropDown_12Label.FontSize = 8;
            app.CreatorDropDown_12Label.Position = [8 4 50 22];
            app.CreatorDropDown_12Label.Text = 'Creator:';

            % Create CreatorDropDown_12
            app.CreatorDropDown_12 = uidropdown(app.InfoPanel_12);
            app.CreatorDropDown_12.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_12.FontSize = 8;
            app.CreatorDropDown_12.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_12.Position = [63 7 100 16];
            app.CreatorDropDown_12.Value = 'Q. Rong';

            % Create Image2_19
            app.Image2_19 = uiimage(app.InfoPanel_12);
            app.Image2_19.Position = [297 8 26 25];
            app.Image2_19.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_12
            app.Image9_12 = uiimage(app.InfoPanel_12);
            app.Image9_12.Position = [328 4 30 28];
            app.Image9_12.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create RollTestLabel_3
            app.RollTestLabel_3 = uilabel(app.InfoPanel_12);
            app.RollTestLabel_3.BackgroundColor = [0.9294 0.6941 0.1255];
            app.RollTestLabel_3.HorizontalAlignment = 'right';
            app.RollTestLabel_3.FontWeight = 'bold';
            app.RollTestLabel_3.Position = [219 59 139 18];
            app.RollTestLabel_3.Text = 'Roll Test';

            % Create RollCamberrelGroundTab
            app.RollCamberrelGroundTab = uitab(app.TabGroup_R_roll_results);
            app.RollCamberrelGroundTab.Title = 'Roll Camber rel. Ground';
            app.RollCamberrelGroundTab.BackgroundColor = [1 1 1];

            % Create GridLayout_13
            app.GridLayout_13 = uigridlayout(app.RollCamberrelGroundTab);
            app.GridLayout_13.ColumnWidth = {'5x', '5x'};
            app.GridLayout_13.RowHeight = {'24x', '8x'};
            app.GridLayout_13.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_R_camber_ground
            app.UIAxesLeft_R_R_camber_ground = uiaxes(app.GridLayout_13);
            title(app.UIAxesLeft_R_R_camber_ground, 'Title')
            xlabel(app.UIAxesLeft_R_R_camber_ground, 'X')
            ylabel(app.UIAxesLeft_R_R_camber_ground, 'Y')
            zlabel(app.UIAxesLeft_R_R_camber_ground, 'Z')
            app.UIAxesLeft_R_R_camber_ground.FontName = 'Times New Roman';
            app.UIAxesLeft_R_R_camber_ground.XLim = [-5 5];
            app.UIAxesLeft_R_R_camber_ground.FontSize = 8;
            app.UIAxesLeft_R_R_camber_ground.Layout.Row = 1;
            app.UIAxesLeft_R_R_camber_ground.Layout.Column = 1;

            % Create UIAxesRight_R_R_camber_ground
            app.UIAxesRight_R_R_camber_ground = uiaxes(app.GridLayout_13);
            title(app.UIAxesRight_R_R_camber_ground, 'Title')
            xlabel(app.UIAxesRight_R_R_camber_ground, 'X')
            ylabel(app.UIAxesRight_R_R_camber_ground, 'Y')
            zlabel(app.UIAxesRight_R_R_camber_ground, 'Z')
            app.UIAxesRight_R_R_camber_ground.FontName = 'Times New Roman';
            app.UIAxesRight_R_R_camber_ground.XLim = [-5 5];
            app.UIAxesRight_R_R_camber_ground.FontSize = 8;
            app.UIAxesRight_R_R_camber_ground.Layout.Row = 1;
            app.UIAxesRight_R_R_camber_ground.Layout.Column = 2;

            % Create ResultEvaluationPanel_13
            app.ResultEvaluationPanel_13 = uipanel(app.GridLayout_13);
            app.ResultEvaluationPanel_13.BorderType = 'none';
            app.ResultEvaluationPanel_13.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_13.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_13.Layout.Row = 2;
            app.ResultEvaluationPanel_13.Layout.Column = 1;
            app.ResultEvaluationPanel_13.FontWeight = 'bold';

            % Create BewertungDropDown_13
            app.BewertungDropDown_13 = uidropdown(app.ResultEvaluationPanel_13);
            app.BewertungDropDown_13.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_13.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_13ValueChanged, true);
            app.BewertungDropDown_13.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_13.Position = [5 57 326 22];
            app.BewertungDropDown_13.Value = 'The current results need further optimization.';

            % Create Lamp_13
            app.Lamp_13 = uilamp(app.ResultEvaluationPanel_13);
            app.Lamp_13.Position = [336 58 20 20];
            app.Lamp_13.Color = [1 1 0.0667];

            % Create TextArea_13
            app.TextArea_13 = uitextarea(app.ResultEvaluationPanel_13);
            app.TextArea_13.Position = [5 3 352 50];

            % Create InfoPanel_13
            app.InfoPanel_13 = uipanel(app.GridLayout_13);
            app.InfoPanel_13.BorderType = 'none';
            app.InfoPanel_13.Title = 'Info.';
            app.InfoPanel_13.BackgroundColor = [1 1 1];
            app.InfoPanel_13.Layout.Row = 2;
            app.InfoPanel_13.Layout.Column = 2;
            app.InfoPanel_13.FontWeight = 'bold';

            % Create DatePicker_13
            app.DatePicker_13 = uidatepicker(app.InfoPanel_13);
            app.DatePicker_13.Position = [175 7 112 18];
            app.DatePicker_13.Value = datetime([2025 1 1]);

            % Create ProjectEditField_13Label
            app.ProjectEditField_13Label = uilabel(app.InfoPanel_13);
            app.ProjectEditField_13Label.HorizontalAlignment = 'right';
            app.ProjectEditField_13Label.Position = [4 57 46 22];
            app.ProjectEditField_13Label.Text = 'Project:';

            % Create ProjectEditField_13
            app.ProjectEditField_13 = uieditfield(app.InfoPanel_13, 'text');
            app.ProjectEditField_13.Position = [63 59 137 18];
            app.ProjectEditField_13.Value = 'Gestamp NRAC';

            % Create VersionEditField_13Label
            app.VersionEditField_13Label = uilabel(app.InfoPanel_13);
            app.VersionEditField_13Label.BackgroundColor = [1 1 1];
            app.VersionEditField_13Label.HorizontalAlignment = 'right';
            app.VersionEditField_13Label.Position = [4 31 48 22];
            app.VersionEditField_13Label.Text = 'Version:';

            % Create VersionEditField_13
            app.VersionEditField_13 = uieditfield(app.InfoPanel_13, 'text');
            app.VersionEditField_13.HorizontalAlignment = 'center';
            app.VersionEditField_13.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_13.Position = [63 34 77 17];
            app.VersionEditField_13.Value = 'G046';

            % Create FlexbodySwitch_13
            app.FlexbodySwitch_13 = uiswitch(app.InfoPanel_13, 'slider');
            app.FlexbodySwitch_13.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_13.FontSize = 9;
            app.FlexbodySwitch_13.Position = [219 34 35 16];
            app.FlexbodySwitch_13.Value = 'Flex-Off';

            % Create CreatorDropDown_13Label
            app.CreatorDropDown_13Label = uilabel(app.InfoPanel_13);
            app.CreatorDropDown_13Label.FontSize = 8;
            app.CreatorDropDown_13Label.Position = [8 4 50 22];
            app.CreatorDropDown_13Label.Text = 'Creator:';

            % Create CreatorDropDown_13
            app.CreatorDropDown_13 = uidropdown(app.InfoPanel_13);
            app.CreatorDropDown_13.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_13.FontSize = 8;
            app.CreatorDropDown_13.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_13.Position = [63 7 100 16];
            app.CreatorDropDown_13.Value = 'Q. Rong';

            % Create Image2_20
            app.Image2_20 = uiimage(app.InfoPanel_13);
            app.Image2_20.Position = [297 8 26 25];
            app.Image2_20.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_13
            app.Image9_13 = uiimage(app.InfoPanel_13);
            app.Image9_13.Position = [328 4 30 28];
            app.Image9_13.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create RollTestLabel_4
            app.RollTestLabel_4 = uilabel(app.InfoPanel_13);
            app.RollTestLabel_4.BackgroundColor = [0.9294 0.6941 0.1255];
            app.RollTestLabel_4.HorizontalAlignment = 'right';
            app.RollTestLabel_4.FontWeight = 'bold';
            app.RollTestLabel_4.Position = [219 59 139 18];
            app.RollTestLabel_4.Text = 'Roll Test';

            % Create OoPBumpSteerTab
            app.OoPBumpSteerTab = uitab(app.TabGroup_R_roll_results);
            app.OoPBumpSteerTab.Title = 'OoP Bump Steer';
            app.OoPBumpSteerTab.BackgroundColor = [1 1 1];

            % Create GridLayout_14
            app.GridLayout_14 = uigridlayout(app.OoPBumpSteerTab);
            app.GridLayout_14.ColumnWidth = {'5x', '5x'};
            app.GridLayout_14.RowHeight = {'24x', '8x'};
            app.GridLayout_14.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_R_toe_WT
            app.UIAxesLeft_R_R_toe_WT = uiaxes(app.GridLayout_14);
            title(app.UIAxesLeft_R_R_toe_WT, 'Title')
            xlabel(app.UIAxesLeft_R_R_toe_WT, 'X')
            ylabel(app.UIAxesLeft_R_R_toe_WT, 'Y')
            zlabel(app.UIAxesLeft_R_R_toe_WT, 'Z')
            app.UIAxesLeft_R_R_toe_WT.FontName = 'Times New Roman';
            app.UIAxesLeft_R_R_toe_WT.XLim = [-100 100];
            app.UIAxesLeft_R_R_toe_WT.FontSize = 8;
            app.UIAxesLeft_R_R_toe_WT.Layout.Row = 1;
            app.UIAxesLeft_R_R_toe_WT.Layout.Column = 1;

            % Create UIAxesRight_R_R_toe_WT
            app.UIAxesRight_R_R_toe_WT = uiaxes(app.GridLayout_14);
            title(app.UIAxesRight_R_R_toe_WT, 'Title')
            xlabel(app.UIAxesRight_R_R_toe_WT, 'X')
            ylabel(app.UIAxesRight_R_R_toe_WT, 'Y')
            zlabel(app.UIAxesRight_R_R_toe_WT, 'Z')
            app.UIAxesRight_R_R_toe_WT.FontName = 'Times New Roman';
            app.UIAxesRight_R_R_toe_WT.XLim = [-100 100];
            app.UIAxesRight_R_R_toe_WT.FontSize = 8;
            app.UIAxesRight_R_R_toe_WT.Layout.Row = 1;
            app.UIAxesRight_R_R_toe_WT.Layout.Column = 2;

            % Create ResultEvaluationPanel_14
            app.ResultEvaluationPanel_14 = uipanel(app.GridLayout_14);
            app.ResultEvaluationPanel_14.BorderType = 'none';
            app.ResultEvaluationPanel_14.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_14.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_14.Layout.Row = 2;
            app.ResultEvaluationPanel_14.Layout.Column = 1;
            app.ResultEvaluationPanel_14.FontWeight = 'bold';

            % Create BewertungDropDown_14
            app.BewertungDropDown_14 = uidropdown(app.ResultEvaluationPanel_14);
            app.BewertungDropDown_14.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_14.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_14ValueChanged, true);
            app.BewertungDropDown_14.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_14.Position = [5 57 326 22];
            app.BewertungDropDown_14.Value = 'The current results need further optimization.';

            % Create Lamp_14
            app.Lamp_14 = uilamp(app.ResultEvaluationPanel_14);
            app.Lamp_14.Position = [336 58 20 20];
            app.Lamp_14.Color = [1 1 0.0667];

            % Create TextArea_14
            app.TextArea_14 = uitextarea(app.ResultEvaluationPanel_14);
            app.TextArea_14.Position = [5 3 352 50];

            % Create InfoPanel_14
            app.InfoPanel_14 = uipanel(app.GridLayout_14);
            app.InfoPanel_14.BorderType = 'none';
            app.InfoPanel_14.Title = 'Info.';
            app.InfoPanel_14.BackgroundColor = [1 1 1];
            app.InfoPanel_14.Layout.Row = 2;
            app.InfoPanel_14.Layout.Column = 2;
            app.InfoPanel_14.FontWeight = 'bold';

            % Create DatePicker_14
            app.DatePicker_14 = uidatepicker(app.InfoPanel_14);
            app.DatePicker_14.Position = [175 7 112 18];
            app.DatePicker_14.Value = datetime([2025 1 1]);

            % Create ProjectEditField_14Label
            app.ProjectEditField_14Label = uilabel(app.InfoPanel_14);
            app.ProjectEditField_14Label.HorizontalAlignment = 'right';
            app.ProjectEditField_14Label.Position = [4 57 46 22];
            app.ProjectEditField_14Label.Text = 'Project:';

            % Create ProjectEditField_14
            app.ProjectEditField_14 = uieditfield(app.InfoPanel_14, 'text');
            app.ProjectEditField_14.Position = [63 59 137 18];
            app.ProjectEditField_14.Value = 'Gestamp NRAC';

            % Create VersionEditField_14Label
            app.VersionEditField_14Label = uilabel(app.InfoPanel_14);
            app.VersionEditField_14Label.BackgroundColor = [1 1 1];
            app.VersionEditField_14Label.HorizontalAlignment = 'right';
            app.VersionEditField_14Label.Position = [4 31 48 22];
            app.VersionEditField_14Label.Text = 'Version:';

            % Create VersionEditField_14
            app.VersionEditField_14 = uieditfield(app.InfoPanel_14, 'text');
            app.VersionEditField_14.HorizontalAlignment = 'center';
            app.VersionEditField_14.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_14.Position = [63 34 77 17];
            app.VersionEditField_14.Value = 'G046';

            % Create FlexbodySwitch_14
            app.FlexbodySwitch_14 = uiswitch(app.InfoPanel_14, 'slider');
            app.FlexbodySwitch_14.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_14.FontSize = 9;
            app.FlexbodySwitch_14.Position = [219 34 35 16];
            app.FlexbodySwitch_14.Value = 'Flex-Off';

            % Create CreatorDropDown_14Label
            app.CreatorDropDown_14Label = uilabel(app.InfoPanel_14);
            app.CreatorDropDown_14Label.FontSize = 8;
            app.CreatorDropDown_14Label.Position = [8 4 50 22];
            app.CreatorDropDown_14Label.Text = 'Creator:';

            % Create CreatorDropDown_14
            app.CreatorDropDown_14 = uidropdown(app.InfoPanel_14);
            app.CreatorDropDown_14.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_14.FontSize = 8;
            app.CreatorDropDown_14.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_14.Position = [63 7 100 16];
            app.CreatorDropDown_14.Value = 'Q. Rong';

            % Create Image2_21
            app.Image2_21 = uiimage(app.InfoPanel_14);
            app.Image2_21.Position = [297 8 26 25];
            app.Image2_21.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_14
            app.Image9_14 = uiimage(app.InfoPanel_14);
            app.Image9_14.Position = [328 4 30 28];
            app.Image9_14.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create RollTestLabel_5
            app.RollTestLabel_5 = uilabel(app.InfoPanel_14);
            app.RollTestLabel_5.BackgroundColor = [0.9294 0.6941 0.1255];
            app.RollTestLabel_5.HorizontalAlignment = 'right';
            app.RollTestLabel_5.FontWeight = 'bold';
            app.RollTestLabel_5.Position = [219 59 139 18];
            app.RollTestLabel_5.Text = 'Roll Test';

            % Create OoPBumpCamberTab
            app.OoPBumpCamberTab = uitab(app.TabGroup_R_roll_results);
            app.OoPBumpCamberTab.Title = 'OoP Bump Camber';
            app.OoPBumpCamberTab.BackgroundColor = [1 1 1];

            % Create GridLayout_15
            app.GridLayout_15 = uigridlayout(app.OoPBumpCamberTab);
            app.GridLayout_15.ColumnWidth = {'5x', '5x'};
            app.GridLayout_15.RowHeight = {'24x', '8x'};
            app.GridLayout_15.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_R_camber_WT
            app.UIAxesLeft_R_R_camber_WT = uiaxes(app.GridLayout_15);
            title(app.UIAxesLeft_R_R_camber_WT, 'Title')
            xlabel(app.UIAxesLeft_R_R_camber_WT, 'X')
            ylabel(app.UIAxesLeft_R_R_camber_WT, 'Y')
            zlabel(app.UIAxesLeft_R_R_camber_WT, 'Z')
            app.UIAxesLeft_R_R_camber_WT.FontName = 'Times New Roman';
            app.UIAxesLeft_R_R_camber_WT.XLim = [-100 100];
            app.UIAxesLeft_R_R_camber_WT.FontSize = 8;
            app.UIAxesLeft_R_R_camber_WT.Layout.Row = 1;
            app.UIAxesLeft_R_R_camber_WT.Layout.Column = 1;

            % Create UIAxesRight_R_R_camber_WT
            app.UIAxesRight_R_R_camber_WT = uiaxes(app.GridLayout_15);
            title(app.UIAxesRight_R_R_camber_WT, 'Title')
            xlabel(app.UIAxesRight_R_R_camber_WT, 'X')
            ylabel(app.UIAxesRight_R_R_camber_WT, 'Y')
            zlabel(app.UIAxesRight_R_R_camber_WT, 'Z')
            app.UIAxesRight_R_R_camber_WT.FontName = 'Times New Roman';
            app.UIAxesRight_R_R_camber_WT.XLim = [-100 100];
            app.UIAxesRight_R_R_camber_WT.FontSize = 8;
            app.UIAxesRight_R_R_camber_WT.Layout.Row = 1;
            app.UIAxesRight_R_R_camber_WT.Layout.Column = 2;

            % Create ResultEvaluationPanel_15
            app.ResultEvaluationPanel_15 = uipanel(app.GridLayout_15);
            app.ResultEvaluationPanel_15.BorderType = 'none';
            app.ResultEvaluationPanel_15.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_15.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_15.Layout.Row = 2;
            app.ResultEvaluationPanel_15.Layout.Column = 1;
            app.ResultEvaluationPanel_15.FontWeight = 'bold';

            % Create BewertungDropDown_15
            app.BewertungDropDown_15 = uidropdown(app.ResultEvaluationPanel_15);
            app.BewertungDropDown_15.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_15.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_15ValueChanged, true);
            app.BewertungDropDown_15.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_15.Position = [5 57 326 22];
            app.BewertungDropDown_15.Value = 'The current results need further optimization.';

            % Create Lamp_15
            app.Lamp_15 = uilamp(app.ResultEvaluationPanel_15);
            app.Lamp_15.Position = [336 58 20 20];
            app.Lamp_15.Color = [1 1 0];

            % Create TextArea_15
            app.TextArea_15 = uitextarea(app.ResultEvaluationPanel_15);
            app.TextArea_15.Position = [5 3 352 50];

            % Create InfoPanel_15
            app.InfoPanel_15 = uipanel(app.GridLayout_15);
            app.InfoPanel_15.BorderType = 'none';
            app.InfoPanel_15.Title = 'Info.';
            app.InfoPanel_15.BackgroundColor = [1 1 1];
            app.InfoPanel_15.Layout.Row = 2;
            app.InfoPanel_15.Layout.Column = 2;
            app.InfoPanel_15.FontWeight = 'bold';

            % Create DatePicker_15
            app.DatePicker_15 = uidatepicker(app.InfoPanel_15);
            app.DatePicker_15.Position = [175 7 112 18];
            app.DatePicker_15.Value = datetime([2025 1 1]);

            % Create ProjectEditField_15Label
            app.ProjectEditField_15Label = uilabel(app.InfoPanel_15);
            app.ProjectEditField_15Label.HorizontalAlignment = 'right';
            app.ProjectEditField_15Label.Position = [4 57 46 22];
            app.ProjectEditField_15Label.Text = 'Project:';

            % Create ProjectEditField_15
            app.ProjectEditField_15 = uieditfield(app.InfoPanel_15, 'text');
            app.ProjectEditField_15.Position = [63 59 137 18];
            app.ProjectEditField_15.Value = 'Gestamp NRAC';

            % Create VersionEditField_15Label
            app.VersionEditField_15Label = uilabel(app.InfoPanel_15);
            app.VersionEditField_15Label.BackgroundColor = [1 1 1];
            app.VersionEditField_15Label.HorizontalAlignment = 'right';
            app.VersionEditField_15Label.Position = [4 31 48 22];
            app.VersionEditField_15Label.Text = 'Version:';

            % Create VersionEditField_15
            app.VersionEditField_15 = uieditfield(app.InfoPanel_15, 'text');
            app.VersionEditField_15.HorizontalAlignment = 'center';
            app.VersionEditField_15.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_15.Position = [63 34 77 17];
            app.VersionEditField_15.Value = 'G046';

            % Create FlexbodySwitch_15
            app.FlexbodySwitch_15 = uiswitch(app.InfoPanel_15, 'slider');
            app.FlexbodySwitch_15.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_15.FontSize = 9;
            app.FlexbodySwitch_15.Position = [219 34 35 16];
            app.FlexbodySwitch_15.Value = 'Flex-Off';

            % Create CreatorDropDown_15Label
            app.CreatorDropDown_15Label = uilabel(app.InfoPanel_15);
            app.CreatorDropDown_15Label.FontSize = 8;
            app.CreatorDropDown_15Label.Position = [8 4 50 22];
            app.CreatorDropDown_15Label.Text = 'Creator:';

            % Create CreatorDropDown_15
            app.CreatorDropDown_15 = uidropdown(app.InfoPanel_15);
            app.CreatorDropDown_15.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_15.FontSize = 8;
            app.CreatorDropDown_15.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_15.Position = [63 7 100 16];
            app.CreatorDropDown_15.Value = 'Q. Rong';

            % Create Image2_22
            app.Image2_22 = uiimage(app.InfoPanel_15);
            app.Image2_22.Position = [297 8 26 25];
            app.Image2_22.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_15
            app.Image9_15 = uiimage(app.InfoPanel_15);
            app.Image9_15.Position = [328 4 30 28];
            app.Image9_15.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create RollTestLabel_6
            app.RollTestLabel_6 = uilabel(app.InfoPanel_15);
            app.RollTestLabel_6.BackgroundColor = [0.0588 1 1];
            app.RollTestLabel_6.HorizontalAlignment = 'right';
            app.RollTestLabel_6.FontWeight = 'bold';
            app.RollTestLabel_6.Position = [219 59 139 18];
            app.RollTestLabel_6.Text = 'Roll Test';

            % Create KinRollCenterHeightTab
            app.KinRollCenterHeightTab = uitab(app.TabGroup_R_roll_results);
            app.KinRollCenterHeightTab.Title = 'Kin. Roll Center Height';
            app.KinRollCenterHeightTab.BackgroundColor = [1 1 1];

            % Create GridLayout_16
            app.GridLayout_16 = uigridlayout(app.KinRollCenterHeightTab);
            app.GridLayout_16.ColumnWidth = {'5x', '5x'};
            app.GridLayout_16.RowHeight = {'24x', '8x'};
            app.GridLayout_16.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_R_rch
            app.UIAxesLeft_R_R_rch = uiaxes(app.GridLayout_16);
            title(app.UIAxesLeft_R_R_rch, 'Title')
            xlabel(app.UIAxesLeft_R_R_rch, 'X')
            ylabel(app.UIAxesLeft_R_R_rch, 'Y')
            zlabel(app.UIAxesLeft_R_R_rch, 'Z')
            app.UIAxesLeft_R_R_rch.FontName = 'Times New Roman';
            app.UIAxesLeft_R_R_rch.XLim = [-5 5];
            app.UIAxesLeft_R_R_rch.FontSize = 8;
            app.UIAxesLeft_R_R_rch.Layout.Row = 1;
            app.UIAxesLeft_R_R_rch.Layout.Column = 1;

            % Create UIAxesRight_R_R_rch
            app.UIAxesRight_R_R_rch = uiaxes(app.GridLayout_16);
            title(app.UIAxesRight_R_R_rch, 'Title')
            xlabel(app.UIAxesRight_R_R_rch, 'X')
            ylabel(app.UIAxesRight_R_R_rch, 'Y')
            zlabel(app.UIAxesRight_R_R_rch, 'Z')
            app.UIAxesRight_R_R_rch.FontName = 'Times New Roman';
            app.UIAxesRight_R_R_rch.XLim = [-5 5];
            app.UIAxesRight_R_R_rch.FontSize = 8;
            app.UIAxesRight_R_R_rch.Layout.Row = 1;
            app.UIAxesRight_R_R_rch.Layout.Column = 2;

            % Create ResultEvaluationPanel_16
            app.ResultEvaluationPanel_16 = uipanel(app.GridLayout_16);
            app.ResultEvaluationPanel_16.BorderType = 'none';
            app.ResultEvaluationPanel_16.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_16.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_16.Layout.Row = 2;
            app.ResultEvaluationPanel_16.Layout.Column = 1;
            app.ResultEvaluationPanel_16.FontWeight = 'bold';

            % Create BewertungDropDown_16
            app.BewertungDropDown_16 = uidropdown(app.ResultEvaluationPanel_16);
            app.BewertungDropDown_16.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_16.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_16ValueChanged, true);
            app.BewertungDropDown_16.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_16.Position = [5 57 326 22];
            app.BewertungDropDown_16.Value = 'The current results need further optimization.';

            % Create Lamp_16
            app.Lamp_16 = uilamp(app.ResultEvaluationPanel_16);
            app.Lamp_16.Position = [336 58 20 20];
            app.Lamp_16.Color = [1 1 0];

            % Create TextArea_16
            app.TextArea_16 = uitextarea(app.ResultEvaluationPanel_16);
            app.TextArea_16.Position = [5 3 352 50];

            % Create InfoPanel_16
            app.InfoPanel_16 = uipanel(app.GridLayout_16);
            app.InfoPanel_16.BorderType = 'none';
            app.InfoPanel_16.Title = 'Info.';
            app.InfoPanel_16.BackgroundColor = [1 1 1];
            app.InfoPanel_16.Layout.Row = 2;
            app.InfoPanel_16.Layout.Column = 2;
            app.InfoPanel_16.FontWeight = 'bold';

            % Create DatePicker_16
            app.DatePicker_16 = uidatepicker(app.InfoPanel_16);
            app.DatePicker_16.Position = [175 7 112 18];
            app.DatePicker_16.Value = datetime([2025 1 1]);

            % Create ProjectEditField_16Label
            app.ProjectEditField_16Label = uilabel(app.InfoPanel_16);
            app.ProjectEditField_16Label.HorizontalAlignment = 'right';
            app.ProjectEditField_16Label.Position = [4 57 46 22];
            app.ProjectEditField_16Label.Text = 'Project:';

            % Create ProjectEditField_16
            app.ProjectEditField_16 = uieditfield(app.InfoPanel_16, 'text');
            app.ProjectEditField_16.Position = [63 59 137 18];
            app.ProjectEditField_16.Value = 'Gestamp NRAC';

            % Create VersionEditField_16Label
            app.VersionEditField_16Label = uilabel(app.InfoPanel_16);
            app.VersionEditField_16Label.BackgroundColor = [1 1 1];
            app.VersionEditField_16Label.HorizontalAlignment = 'right';
            app.VersionEditField_16Label.Position = [4 31 48 22];
            app.VersionEditField_16Label.Text = 'Version:';

            % Create VersionEditField_16
            app.VersionEditField_16 = uieditfield(app.InfoPanel_16, 'text');
            app.VersionEditField_16.HorizontalAlignment = 'center';
            app.VersionEditField_16.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_16.Position = [63 34 77 17];
            app.VersionEditField_16.Value = 'G046';

            % Create FlexbodySwitch_16
            app.FlexbodySwitch_16 = uiswitch(app.InfoPanel_16, 'slider');
            app.FlexbodySwitch_16.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_16.FontSize = 9;
            app.FlexbodySwitch_16.Position = [219 34 35 16];
            app.FlexbodySwitch_16.Value = 'Flex-Off';

            % Create Image2_23
            app.Image2_23 = uiimage(app.InfoPanel_16);
            app.Image2_23.Position = [297 8 26 25];
            app.Image2_23.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_16Label
            app.CreatorDropDown_16Label = uilabel(app.InfoPanel_16);
            app.CreatorDropDown_16Label.FontSize = 8;
            app.CreatorDropDown_16Label.Position = [8 4 50 22];
            app.CreatorDropDown_16Label.Text = 'Creator:';

            % Create CreatorDropDown_16
            app.CreatorDropDown_16 = uidropdown(app.InfoPanel_16);
            app.CreatorDropDown_16.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_16.FontSize = 8;
            app.CreatorDropDown_16.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_16.Position = [63 7 100 16];
            app.CreatorDropDown_16.Value = 'Q. Rong';

            % Create Image9_16
            app.Image9_16 = uiimage(app.InfoPanel_16);
            app.Image9_16.Position = [328 4 30 28];
            app.Image9_16.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create RollTestLabel_7
            app.RollTestLabel_7 = uilabel(app.InfoPanel_16);
            app.RollTestLabel_7.BackgroundColor = [0.0588 1 1];
            app.RollTestLabel_7.HorizontalAlignment = 'right';
            app.RollTestLabel_7.FontWeight = 'bold';
            app.RollTestLabel_7.Position = [219 59 139 18];
            app.RollTestLabel_7.Text = 'Roll Test';

            % Create ResultsPanel_R_roll
            app.ResultsPanel_R_roll = uipanel(app.Tab_KcRear_Roll);
            app.ResultsPanel_R_roll.BorderWidth = 0.5;
            app.ResultsPanel_R_roll.Title = 'Results';
            app.ResultsPanel_R_roll.BackgroundColor = [1 1 1];
            app.ResultsPanel_R_roll.FontName = 'Times New Roman';
            app.ResultsPanel_R_roll.Position = [19 11 275 468];

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.ResultsPanel_R_roll);
            app.GridLayout3.ColumnWidth = {100, 55, 100};
            app.GridLayout3.RowHeight = {18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 20, '1x', 4};
            app.GridLayout3.ColumnSpacing = 4.5;
            app.GridLayout3.RowSpacing = 5.58823529411765;
            app.GridLayout3.Padding = [4.5 5.58823529411765 4.5 5.58823529411765];
            app.GridLayout3.BackgroundColor = [1 1 1];

            % Create Label
            app.Label = uilabel(app.GridLayout3);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontName = 'Times New Roman';
            app.Label.FontSize = 8;
            app.Label.Layout.Row = 2;
            app.Label.Layout.Column = 3;
            app.Label.Text = '[-0.02 ~ +0.04]';

            % Create tbdLabel
            app.tbdLabel = uilabel(app.GridLayout3);
            app.tbdLabel.HorizontalAlignment = 'center';
            app.tbdLabel.FontName = 'Times New Roman';
            app.tbdLabel.Layout.Row = 4;
            app.tbdLabel.Layout.Column = 3;
            app.tbdLabel.Text = '[t. b. d.]';

            % Create tbdLabel_2
            app.tbdLabel_2 = uilabel(app.GridLayout3);
            app.tbdLabel_2.HorizontalAlignment = 'center';
            app.tbdLabel_2.FontName = 'Times New Roman';
            app.tbdLabel_2.Layout.Row = 6;
            app.tbdLabel_2.Layout.Column = 3;
            app.tbdLabel_2.Text = '[t. b. d.]';

            % Create tbdLabel_3
            app.tbdLabel_3 = uilabel(app.GridLayout3);
            app.tbdLabel_3.HorizontalAlignment = 'center';
            app.tbdLabel_3.FontName = 'Times New Roman';
            app.tbdLabel_3.Layout.Row = 8;
            app.tbdLabel_3.Layout.Column = 3;
            app.tbdLabel_3.Text = '[t. b. d.]';

            % Create tbdLabel_4
            app.tbdLabel_4 = uilabel(app.GridLayout3);
            app.tbdLabel_4.HorizontalAlignment = 'center';
            app.tbdLabel_4.FontName = 'Times New Roman';
            app.tbdLabel_4.Layout.Row = 10;
            app.tbdLabel_4.Layout.Column = 3;
            app.tbdLabel_4.Text = '[t. b. d.]';

            % Create tbdLabel_5
            app.tbdLabel_5 = uilabel(app.GridLayout3);
            app.tbdLabel_5.HorizontalAlignment = 'center';
            app.tbdLabel_5.FontName = 'Times New Roman';
            app.tbdLabel_5.Layout.Row = 12;
            app.tbdLabel_5.Layout.Column = 3;
            app.tbdLabel_5.Text = '[t. b. d.]';

            % Create tbdLabel_6
            app.tbdLabel_6 = uilabel(app.GridLayout3);
            app.tbdLabel_6.HorizontalAlignment = 'center';
            app.tbdLabel_6.FontName = 'Times New Roman';
            app.tbdLabel_6.Layout.Row = 14;
            app.tbdLabel_6.Layout.Column = 3;
            app.tbdLabel_6.Text = '[t. b. d.]';

            % Create tbdLabel_7
            app.tbdLabel_7 = uilabel(app.GridLayout3);
            app.tbdLabel_7.HorizontalAlignment = 'center';
            app.tbdLabel_7.FontName = 'Times New Roman';
            app.tbdLabel_7.Layout.Row = 16;
            app.tbdLabel_7.Layout.Column = 3;
            app.tbdLabel_7.Text = '[t. b. d.]';

            % Create RollRateWCEditFieldLabel
            app.RollRateWCEditFieldLabel = uilabel(app.GridLayout3);
            app.RollRateWCEditFieldLabel.VerticalAlignment = 'bottom';
            app.RollRateWCEditFieldLabel.FontName = 'Times New Roman';
            app.RollRateWCEditFieldLabel.Layout.Row = 1;
            app.RollRateWCEditFieldLabel.Layout.Column = 1;
            app.RollRateWCEditFieldLabel.Text = 'Roll Rate@WC';

            % Create R_rollrateEditField
            app.R_rollrateEditField = uieditfield(app.GridLayout3, 'numeric');
            app.R_rollrateEditField.FontName = 'Times New Roman';
            app.R_rollrateEditField.Layout.Row = 2;
            app.R_rollrateEditField.Layout.Column = 1;

            % Create ToeChangeWCEditFieldLabel
            app.ToeChangeWCEditFieldLabel = uilabel(app.GridLayout3);
            app.ToeChangeWCEditFieldLabel.VerticalAlignment = 'bottom';
            app.ToeChangeWCEditFieldLabel.FontName = 'Times New Roman';
            app.ToeChangeWCEditFieldLabel.Layout.Row = 3;
            app.ToeChangeWCEditFieldLabel.Layout.Column = 1;
            app.ToeChangeWCEditFieldLabel.Text = 'Toe Change@WC';

            % Create RollSteerEditField
            app.RollSteerEditField = uieditfield(app.GridLayout3, 'numeric');
            app.RollSteerEditField.FontName = 'Times New Roman';
            app.RollSteerEditField.Layout.Row = 4;
            app.RollSteerEditField.Layout.Column = 1;

            % Create RollCamberEditFieldLabel
            app.RollCamberEditFieldLabel = uilabel(app.GridLayout3);
            app.RollCamberEditFieldLabel.VerticalAlignment = 'bottom';
            app.RollCamberEditFieldLabel.FontName = 'Times New Roman';
            app.RollCamberEditFieldLabel.Layout.Row = 5;
            app.RollCamberEditFieldLabel.Layout.Column = 1;
            app.RollCamberEditFieldLabel.Text = 'Roll Camber';

            % Create RollCamberEditField
            app.RollCamberEditField = uieditfield(app.GridLayout3, 'numeric');
            app.RollCamberEditField.FontName = 'Times New Roman';
            app.RollCamberEditField.Layout.Row = 6;
            app.RollCamberEditField.Layout.Column = 1;

            % Create CamberRelGroundEditFieldLabel
            app.CamberRelGroundEditFieldLabel = uilabel(app.GridLayout3);
            app.CamberRelGroundEditFieldLabel.VerticalAlignment = 'bottom';
            app.CamberRelGroundEditFieldLabel.FontName = 'Times New Roman';
            app.CamberRelGroundEditFieldLabel.Layout.Row = 7;
            app.CamberRelGroundEditFieldLabel.Layout.Column = 1;
            app.CamberRelGroundEditFieldLabel.Text = 'Camber Rel. Ground';

            % Create RollCamberGroundEditField
            app.RollCamberGroundEditField = uieditfield(app.GridLayout3, 'numeric');
            app.RollCamberGroundEditField.FontName = 'Times New Roman';
            app.RollCamberGroundEditField.Layout.Row = 8;
            app.RollCamberGroundEditField.Layout.Column = 1;

            % Create OutofPhaseSteerEditFieldLabel
            app.OutofPhaseSteerEditFieldLabel = uilabel(app.GridLayout3);
            app.OutofPhaseSteerEditFieldLabel.FontName = 'Times New Roman';
            app.OutofPhaseSteerEditFieldLabel.Layout.Row = 9;
            app.OutofPhaseSteerEditFieldLabel.Layout.Column = [1 2];
            app.OutofPhaseSteerEditFieldLabel.Text = 'Out-of-Phase Steer';

            % Create RollSteerWTEditField
            app.RollSteerWTEditField = uieditfield(app.GridLayout3, 'numeric');
            app.RollSteerWTEditField.FontName = 'Times New Roman';
            app.RollSteerWTEditField.Layout.Row = 10;
            app.RollSteerWTEditField.Layout.Column = 1;

            % Create OutofPhaseCamberEditFieldLabel
            app.OutofPhaseCamberEditFieldLabel = uilabel(app.GridLayout3);
            app.OutofPhaseCamberEditFieldLabel.FontName = 'Times New Roman';
            app.OutofPhaseCamberEditFieldLabel.Layout.Row = 11;
            app.OutofPhaseCamberEditFieldLabel.Layout.Column = [1 2];
            app.OutofPhaseCamberEditFieldLabel.Text = 'Out-of-Phase Camber';

            % Create RollCamberWTEditField
            app.RollCamberWTEditField = uieditfield(app.GridLayout3, 'numeric');
            app.RollCamberWTEditField.FontName = 'Times New Roman';
            app.RollCamberWTEditField.Layout.Row = 12;
            app.RollCamberWTEditField.Layout.Column = 1;

            % Create KinRollCenterHeightEditFieldLabel
            app.KinRollCenterHeightEditFieldLabel = uilabel(app.GridLayout3);
            app.KinRollCenterHeightEditFieldLabel.VerticalAlignment = 'bottom';
            app.KinRollCenterHeightEditFieldLabel.FontName = 'Times New Roman';
            app.KinRollCenterHeightEditFieldLabel.Layout.Row = 13;
            app.KinRollCenterHeightEditFieldLabel.Layout.Column = [1 2];
            app.KinRollCenterHeightEditFieldLabel.Text = 'Kin. Roll Center Height';

            % Create RollRCHEditField
            app.RollRCHEditField = uieditfield(app.GridLayout3, 'numeric');
            app.RollRCHEditField.FontName = 'Times New Roman';
            app.RollRCHEditField.Layout.Row = 14;
            app.RollRCHEditField.Layout.Column = 1;

            % Create RCHChangeEditFieldLabel
            app.RCHChangeEditFieldLabel = uilabel(app.GridLayout3);
            app.RCHChangeEditFieldLabel.VerticalAlignment = 'bottom';
            app.RCHChangeEditFieldLabel.FontName = 'Times New Roman';
            app.RCHChangeEditFieldLabel.Layout.Row = 15;
            app.RCHChangeEditFieldLabel.Layout.Column = 1;
            app.RCHChangeEditFieldLabel.Text = 'RCH Change';

            % Create RollRCHchangeEditField
            app.RollRCHchangeEditField = uieditfield(app.GridLayout3, 'numeric');
            app.RollRCHchangeEditField.FontName = 'Times New Roman';
            app.RollRCHchangeEditField.Layout.Row = 16;
            app.RollRCHchangeEditField.Layout.Column = 1;

            % Create NmLabel
            app.NmLabel = uilabel(app.GridLayout3);
            app.NmLabel.HorizontalAlignment = 'center';
            app.NmLabel.FontName = 'Times New Roman';
            app.NmLabel.Layout.Row = 2;
            app.NmLabel.Layout.Column = 2;
            app.NmLabel.Text = 'Nm/°';

            % Create Label_4
            app.Label_4 = uilabel(app.GridLayout3);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontName = 'Times New Roman';
            app.Label_4.Layout.Row = 4;
            app.Label_4.Layout.Column = 2;
            app.Label_4.Text = '°/°';

            % Create MTSLabel
            app.MTSLabel = uilabel(app.GridLayout3);
            app.MTSLabel.HorizontalAlignment = 'center';
            app.MTSLabel.FontName = 'Times New Roman';
            app.MTSLabel.Layout.Row = 6;
            app.MTSLabel.Layout.Column = 2;
            app.MTSLabel.Text = '°/° (MTS)';

            % Create ABDLabel
            app.ABDLabel = uilabel(app.GridLayout3);
            app.ABDLabel.HorizontalAlignment = 'center';
            app.ABDLabel.FontName = 'Times New Roman';
            app.ABDLabel.Layout.Row = 8;
            app.ABDLabel.Layout.Column = 2;
            app.ABDLabel.Text = '°/° (ABD)';

            % Create mLabel
            app.mLabel = uilabel(app.GridLayout3);
            app.mLabel.HorizontalAlignment = 'center';
            app.mLabel.FontName = 'Times New Roman';
            app.mLabel.Layout.Row = 10;
            app.mLabel.Layout.Column = 2;
            app.mLabel.Text = '°/m';

            % Create mLabel_2
            app.mLabel_2 = uilabel(app.GridLayout3);
            app.mLabel_2.HorizontalAlignment = 'center';
            app.mLabel_2.FontName = 'Times New Roman';
            app.mLabel_2.Layout.Row = 12;
            app.mLabel_2.Layout.Column = 2;
            app.mLabel_2.Text = '°/m';

            % Create mmLabel_8
            app.mmLabel_8 = uilabel(app.GridLayout3);
            app.mmLabel_8.HorizontalAlignment = 'center';
            app.mmLabel_8.FontName = 'Times New Roman';
            app.mmLabel_8.Layout.Row = 14;
            app.mmLabel_8.Layout.Column = 2;
            app.mmLabel_8.Text = 'mm';

            % Create mmLabel_9
            app.mmLabel_9 = uilabel(app.GridLayout3);
            app.mmLabel_9.HorizontalAlignment = 'center';
            app.mmLabel_9.FontName = 'Times New Roman';
            app.mmLabel_9.Layout.Row = 16;
            app.mmLabel_9.Layout.Column = 2;
            app.mmLabel_9.Text = 'mm/°';

            % Create RollClearAxesButton
            app.RollClearAxesButton = uibutton(app.GridLayout3, 'push');
            app.RollClearAxesButton.ButtonPushedFcn = createCallbackFcn(app, @RollClearAxesButtonPushed, true);
            app.RollClearAxesButton.Layout.Row = 18;
            app.RollClearAxesButton.Layout.Column = 3;
            app.RollClearAxesButton.Text = 'Plot Clear';

            % Create PositivDirectionButton_2
            app.PositivDirectionButton_2 = uibutton(app.GridLayout3, 'push');
            app.PositivDirectionButton_2.Layout.Row = 18;
            app.PositivDirectionButton_2.Layout.Column = 1;
            app.PositivDirectionButton_2.Text = 'Positiv Direction';

            % Create NRACTargetLabel
            app.NRACTargetLabel = uilabel(app.GridLayout3);
            app.NRACTargetLabel.FontName = 'Times New Roman';
            app.NRACTargetLabel.Layout.Row = 1;
            app.NRACTargetLabel.Layout.Column = 3;
            app.NRACTargetLabel.Text = 'NRAC Target';

            % Create GOButton_R_roll
            app.GOButton_R_roll = uibutton(app.Tab_KcRear_Roll, 'push');
            app.GOButton_R_roll.ButtonPushedFcn = createCallbackFcn(app, @GOButton_R_rollPushed, true);
            app.GOButton_R_roll.Tag = 'executeFunctionButton';
            app.GOButton_R_roll.Position = [740 500 100 23];
            app.GOButton_R_roll.Text = 'GO!';

            % Create EditField_browser_R_roll
            app.EditField_browser_R_roll = uieditfield(app.Tab_KcRear_Roll, 'text');
            app.EditField_browser_R_roll.Tag = 'filePathEditField';
            app.EditField_browser_R_roll.Position = [209 500 512 22];

            % Create Button_browser_R_roll
            app.Button_browser_R_roll = uibutton(app.Tab_KcRear_Roll, 'push');
            app.Button_browser_R_roll.ButtonPushedFcn = createCallbackFcn(app, @Button_browser_R_rollPushed, true);
            app.Button_browser_R_roll.Tag = 'selectFileButton';
            app.Button_browser_R_roll.Position = [19 500 100 23];
            app.Button_browser_R_roll.Text = 'Select File ...';

            % Create FittingRangeKnob_2Label
            app.FittingRangeKnob_2Label = uilabel(app.Tab_KcRear_Roll);
            app.FittingRangeKnob_2Label.HorizontalAlignment = 'center';
            app.FittingRangeKnob_2Label.FontName = 'Times New Roman';
            app.FittingRangeKnob_2Label.FontSize = 8;
            app.FittingRangeKnob_2Label.Position = [866 512 77 22];
            app.FittingRangeKnob_2Label.Text = 'Fitting Range=';

            % Create BYDDelphinButton_7
            app.BYDDelphinButton_7 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.BYDDelphinButton_7.Text = 'BYD Delphin';
            app.BYDDelphinButton_7.Position = [1075 430 88 23];

            % Create VWPassatButton_7
            app.VWPassatButton_7 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.VWPassatButton_7.Text = 'VW Passat';
            app.VWPassatButton_7.Position = [1075 404 88 23];

            % Create TeslaModel3Button_7
            app.TeslaModel3Button_7 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.TeslaModel3Button_7.Text = 'Tesla Model 3';
            app.TeslaModel3Button_7.Position = [1075 293 89 23];

            % Create FORDEDGEButton_7
            app.FORDEDGEButton_7 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.FORDEDGEButton_7.Text = 'FORD EDGE';
            app.FORDEDGEButton_7.Position = [1075 378 88 23];

            % Create RefVehicleLabel_7
            app.RefVehicleLabel_7 = uilabel(app.Tab_KcRear_Roll);
            app.RefVehicleLabel_7.FontWeight = 'bold';
            app.RefVehicleLabel_7.Position = [1081 510 72 22];
            app.RefVehicleLabel_7.Text = 'Ref. Vehicle';

            % Create ABDSPMMPlusLabel_4
            app.ABDSPMMPlusLabel_4 = uilabel(app.Tab_KcRear_Roll);
            app.ABDSPMMPlusLabel_4.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_4.FontSize = 10;
            app.ABDSPMMPlusLabel_4.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_4.Position = [1069 480 108 22];
            app.ABDSPMMPlusLabel_4.Text = '* ABD SPMM Plus';

            % Create TestBenchResultsLabel_2
            app.TestBenchResultsLabel_2 = uilabel(app.Tab_KcRear_Roll);
            app.TestBenchResultsLabel_2.FontName = 'Times New Roman';
            app.TestBenchResultsLabel_2.FontSize = 10;
            app.TestBenchResultsLabel_2.FontAngle = 'italic';
            app.TestBenchResultsLabel_2.Position = [1069 459 108 22];
            app.TestBenchResultsLabel_2.Text = '   Test Bench Results';

            % Create ABDSPMMPlusLabel_5
            app.ABDSPMMPlusLabel_5 = uilabel(app.Tab_KcRear_Roll);
            app.ABDSPMMPlusLabel_5.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_5.FontSize = 10;
            app.ABDSPMMPlusLabel_5.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_5.Position = [1069 343 108 22];
            app.ABDSPMMPlusLabel_5.Text = '* ABD SPMM Plus';

            % Create TestReportLabel_2
            app.TestReportLabel_2 = uilabel(app.Tab_KcRear_Roll);
            app.TestReportLabel_2.FontName = 'Times New Roman';
            app.TestReportLabel_2.FontSize = 10;
            app.TestReportLabel_2.FontAngle = 'italic';
            app.TestReportLabel_2.Position = [1069 322 108 22];
            app.TestReportLabel_2.Text = '   Test Report';

            % Create VWID3Button_2
            app.VWID3Button_2 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.VWID3Button_2.Text = 'VW ID.3';
            app.VWID3Button_2.Position = [1075 267 89 23];

            % Create BMW325iButton_2
            app.BMW325iButton_2 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.BMW325iButton_2.Text = 'BMW 325i';
            app.BMW325iButton_2.Position = [1075 241 89 23];

            % Create TOYOTAYarisButton_2
            app.TOYOTAYarisButton_2 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.TOYOTAYarisButton_2.Text = 'TOYOTA Yaris';
            app.TOYOTAYarisButton_2.Position = [1075 79 89 23];

            % Create BYDDolphinButton_2
            app.BYDDolphinButton_2 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.BYDDolphinButton_2.Text = 'BYD Dolphin';
            app.BYDDolphinButton_2.Position = [1075 157 89 23];

            % Create ABDSPMMPlusLabel_6
            app.ABDSPMMPlusLabel_6 = uilabel(app.Tab_KcRear_Roll);
            app.ABDSPMMPlusLabel_6.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_6.FontSize = 10;
            app.ABDSPMMPlusLabel_6.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_6.Position = [1069 207 108 22];
            app.ABDSPMMPlusLabel_6.Text = '* ABD SPMM Plus';

            % Create TwistBeamLabel_2
            app.TwistBeamLabel_2 = uilabel(app.Tab_KcRear_Roll);
            app.TwistBeamLabel_2.FontName = 'Times New Roman';
            app.TwistBeamLabel_2.FontSize = 10;
            app.TwistBeamLabel_2.FontAngle = 'italic';
            app.TwistBeamLabel_2.Position = [1069 186 108 22];
            app.TwistBeamLabel_2.Text = '   TwistBeam';

            % Create VWGolfButton_3
            app.VWGolfButton_3 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.VWGolfButton_3.Text = 'VW Golf';
            app.VWGolfButton_3.Position = [1075 131 89 23];

            % Create VWUPButton_2
            app.VWUPButton_2 = uibutton(app.Tab_KcRear_Roll, 'state');
            app.VWUPButton_2.Text = 'VW UP!';
            app.VWUPButton_2.Position = [1075 105 89 23];

            % Create Button_3
            app.Button_3 = uibutton(app.Tab_KcRear_Roll, 'push');
            app.Button_3.Icon = fullfile(pathToMLAPP, 'Icon_plot_custerm.png');
            app.Button_3.Position = [1075 11 40 41];
            app.Button_3.Text = '';

            % Create Button_4
            app.Button_4 = uibutton(app.Tab_KcRear_Roll, 'push');
            app.Button_4.Icon = fullfile(pathToMLAPP, 'icon_to_ppt.png');
            app.Button_4.Position = [1127 12 37 40];
            app.Button_4.Text = '';

            % Create Tab_KcRear_LateralForce
            app.Tab_KcRear_LateralForce = uitab(app.Tab_KcRear);
            app.Tab_KcRear_LateralForce.Title = 'Lateral Force (Paraell)';

            % Create EditField_R_lat_rangeshow
            app.EditField_R_lat_rangeshow = uieditfield(app.Tab_KcRear_LateralForce, 'numeric');
            app.EditField_R_lat_rangeshow.FontName = 'Times New Roman';
            app.EditField_R_lat_rangeshow.FontSize = 10;
            app.EditField_R_lat_rangeshow.Position = [871 491 46 18];
            app.EditField_R_lat_rangeshow.Value = 500;

            % Create mmLabel_R_lat_rangshow
            app.mmLabel_R_lat_rangshow = uilabel(app.Tab_KcRear_LateralForce);
            app.mmLabel_R_lat_rangshow.FontName = 'Times New Roman';
            app.mmLabel_R_lat_rangshow.Position = [918 489 43 22];
            app.mmLabel_R_lat_rangshow.Text = '* +/-1N';

            % Create TabGroup_R_roll_results_2
            app.TabGroup_R_roll_results_2 = uitabgroup(app.Tab_KcRear_LateralForce);
            app.TabGroup_R_roll_results_2.Position = [304 10 756 468];

            % Create LatForceSteerTab
            app.LatForceSteerTab = uitab(app.TabGroup_R_roll_results_2);
            app.LatForceSteerTab.Title = 'Lat. Force Steer';
            app.LatForceSteerTab.BackgroundColor = [1 1 1];

            % Create GridLayout_18
            app.GridLayout_18 = uigridlayout(app.LatForceSteerTab);
            app.GridLayout_18.ColumnWidth = {'5x', '5x'};
            app.GridLayout_18.RowHeight = {'24x', '8x'};
            app.GridLayout_18.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_lattoe
            app.UIAxesLeft_R_lattoe = uiaxes(app.GridLayout_18);
            title(app.UIAxesLeft_R_lattoe, 'Title')
            xlabel(app.UIAxesLeft_R_lattoe, 'X')
            ylabel(app.UIAxesLeft_R_lattoe, 'Y')
            zlabel(app.UIAxesLeft_R_lattoe, 'Z')
            app.UIAxesLeft_R_lattoe.FontName = 'Times New Roman';
            app.UIAxesLeft_R_lattoe.XLim = [-4000 4000];
            app.UIAxesLeft_R_lattoe.GridLineWidth = 0.1;
            app.UIAxesLeft_R_lattoe.GridAlpha = 0.1;
            app.UIAxesLeft_R_lattoe.FontSize = 10;
            app.UIAxesLeft_R_lattoe.Layout.Row = 1;
            app.UIAxesLeft_R_lattoe.Layout.Column = 1;

            % Create UIAxesRight_R_lattoe
            app.UIAxesRight_R_lattoe = uiaxes(app.GridLayout_18);
            title(app.UIAxesRight_R_lattoe, 'Title')
            xlabel(app.UIAxesRight_R_lattoe, 'X')
            ylabel(app.UIAxesRight_R_lattoe, 'Y')
            zlabel(app.UIAxesRight_R_lattoe, 'Z')
            app.UIAxesRight_R_lattoe.FontName = 'Times New Roman';
            app.UIAxesRight_R_lattoe.XLim = [-4000 4000];
            app.UIAxesRight_R_lattoe.FontSize = 10;
            app.UIAxesRight_R_lattoe.Layout.Row = 1;
            app.UIAxesRight_R_lattoe.Layout.Column = 2;

            % Create InfoPanel_18
            app.InfoPanel_18 = uipanel(app.GridLayout_18);
            app.InfoPanel_18.BorderType = 'none';
            app.InfoPanel_18.Title = 'Info.';
            app.InfoPanel_18.BackgroundColor = [1 1 1];
            app.InfoPanel_18.Layout.Row = 2;
            app.InfoPanel_18.Layout.Column = 2;
            app.InfoPanel_18.FontWeight = 'bold';

            % Create DatePicker_18
            app.DatePicker_18 = uidatepicker(app.InfoPanel_18);
            app.DatePicker_18.Position = [175 7 112 18];
            app.DatePicker_18.Value = datetime([2025 1 1]);

            % Create VersionEditField_18Label
            app.VersionEditField_18Label = uilabel(app.InfoPanel_18);
            app.VersionEditField_18Label.BackgroundColor = [1 1 1];
            app.VersionEditField_18Label.HorizontalAlignment = 'right';
            app.VersionEditField_18Label.Position = [4 32 48 22];
            app.VersionEditField_18Label.Text = 'Version:';

            % Create VersionEditField_18
            app.VersionEditField_18 = uieditfield(app.InfoPanel_18, 'text');
            app.VersionEditField_18.HorizontalAlignment = 'center';
            app.VersionEditField_18.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_18.Position = [63 34 77 17];
            app.VersionEditField_18.Value = 'G046';

            % Create FlexbodySwitch_18
            app.FlexbodySwitch_18 = uiswitch(app.InfoPanel_18, 'slider');
            app.FlexbodySwitch_18.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_18.FontSize = 9;
            app.FlexbodySwitch_18.Position = [219 34 35 16];
            app.FlexbodySwitch_18.Value = 'Flex-Off';

            % Create CreatorDropDown_18Label
            app.CreatorDropDown_18Label = uilabel(app.InfoPanel_18);
            app.CreatorDropDown_18Label.FontSize = 8;
            app.CreatorDropDown_18Label.Position = [8 5 50 22];
            app.CreatorDropDown_18Label.Text = 'Creator:';

            % Create CreatorDropDown_18
            app.CreatorDropDown_18 = uidropdown(app.InfoPanel_18);
            app.CreatorDropDown_18.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_18.FontSize = 8;
            app.CreatorDropDown_18.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_18.Position = [63 7 100 16];
            app.CreatorDropDown_18.Value = 'Q. Rong';

            % Create Image2_25
            app.Image2_25 = uiimage(app.InfoPanel_18);
            app.Image2_25.Position = [297 8 26 25];
            app.Image2_25.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_18
            app.Image9_18 = uiimage(app.InfoPanel_18);
            app.Image9_18.Position = [328 4 30 28];
            app.Image9_18.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create LateralForceTestLabel_8
            app.LateralForceTestLabel_8 = uilabel(app.InfoPanel_18);
            app.LateralForceTestLabel_8.BackgroundColor = [0.9294 0.6941 0.1255];
            app.LateralForceTestLabel_8.HorizontalAlignment = 'right';
            app.LateralForceTestLabel_8.FontWeight = 'bold';
            app.LateralForceTestLabel_8.Position = [219 55 139 22];
            app.LateralForceTestLabel_8.Text = 'Lateral Force Test';

            % Create ProjectEditField_25Label
            app.ProjectEditField_25Label = uilabel(app.InfoPanel_18);
            app.ProjectEditField_25Label.HorizontalAlignment = 'right';
            app.ProjectEditField_25Label.Position = [4 57 46 22];
            app.ProjectEditField_25Label.Text = 'Project:';

            % Create ProjectEditField_25
            app.ProjectEditField_25 = uieditfield(app.InfoPanel_18, 'text');
            app.ProjectEditField_25.Position = [63 59 137 18];
            app.ProjectEditField_25.Value = 'Gestamp NRAC';

            % Create ResultEvaluationPanel_18
            app.ResultEvaluationPanel_18 = uipanel(app.GridLayout_18);
            app.ResultEvaluationPanel_18.BorderType = 'none';
            app.ResultEvaluationPanel_18.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_18.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_18.Layout.Row = 2;
            app.ResultEvaluationPanel_18.Layout.Column = 1;
            app.ResultEvaluationPanel_18.FontWeight = 'bold';

            % Create BewertungDropDown_18
            app.BewertungDropDown_18 = uidropdown(app.ResultEvaluationPanel_18);
            app.BewertungDropDown_18.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_18.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_18ValueChanged, true);
            app.BewertungDropDown_18.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_18.Position = [5 57 326 22];
            app.BewertungDropDown_18.Value = 'The current results need further optimization.';

            % Create Lamp_18
            app.Lamp_18 = uilamp(app.ResultEvaluationPanel_18);
            app.Lamp_18.Position = [336 58 20 20];
            app.Lamp_18.Color = [1 1 0.0667];

            % Create TextArea_18
            app.TextArea_18 = uitextarea(app.ResultEvaluationPanel_18);
            app.TextArea_18.Position = [5 3 352 50];

            % Create LatForceCamberTab
            app.LatForceCamberTab = uitab(app.TabGroup_R_roll_results_2);
            app.LatForceCamberTab.Title = 'Lat. Force Camber';
            app.LatForceCamberTab.BackgroundColor = [1 1 1];

            % Create GridLayout_19
            app.GridLayout_19 = uigridlayout(app.LatForceCamberTab);
            app.GridLayout_19.ColumnWidth = {'5x', '5x'};
            app.GridLayout_19.RowHeight = {'24x', '8x'};
            app.GridLayout_19.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_latcamber
            app.UIAxesLeft_R_latcamber = uiaxes(app.GridLayout_19);
            title(app.UIAxesLeft_R_latcamber, 'Title')
            xlabel(app.UIAxesLeft_R_latcamber, 'X')
            ylabel(app.UIAxesLeft_R_latcamber, 'Y')
            zlabel(app.UIAxesLeft_R_latcamber, 'Z')
            app.UIAxesLeft_R_latcamber.FontName = 'Times New Roman';
            app.UIAxesLeft_R_latcamber.XLim = [-4000 4000];
            app.UIAxesLeft_R_latcamber.FontSize = 10;
            app.UIAxesLeft_R_latcamber.Layout.Row = 1;
            app.UIAxesLeft_R_latcamber.Layout.Column = 1;

            % Create UIAxesRight_R_latcamber
            app.UIAxesRight_R_latcamber = uiaxes(app.GridLayout_19);
            title(app.UIAxesRight_R_latcamber, 'Title')
            xlabel(app.UIAxesRight_R_latcamber, 'X')
            ylabel(app.UIAxesRight_R_latcamber, 'Y')
            zlabel(app.UIAxesRight_R_latcamber, 'Z')
            app.UIAxesRight_R_latcamber.FontName = 'Times New Roman';
            app.UIAxesRight_R_latcamber.XLim = [-4000 4000];
            app.UIAxesRight_R_latcamber.FontSize = 10;
            app.UIAxesRight_R_latcamber.Layout.Row = 1;
            app.UIAxesRight_R_latcamber.Layout.Column = 2;

            % Create ResultEvaluationPanel_19
            app.ResultEvaluationPanel_19 = uipanel(app.GridLayout_19);
            app.ResultEvaluationPanel_19.BorderType = 'none';
            app.ResultEvaluationPanel_19.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_19.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_19.Layout.Row = 2;
            app.ResultEvaluationPanel_19.Layout.Column = 1;
            app.ResultEvaluationPanel_19.FontWeight = 'bold';

            % Create BewertungDropDown_19
            app.BewertungDropDown_19 = uidropdown(app.ResultEvaluationPanel_19);
            app.BewertungDropDown_19.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_19.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_19ValueChanged, true);
            app.BewertungDropDown_19.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_19.Position = [5 57 326 22];
            app.BewertungDropDown_19.Value = 'The current results need further optimization.';

            % Create Lamp_19
            app.Lamp_19 = uilamp(app.ResultEvaluationPanel_19);
            app.Lamp_19.Position = [336 58 20 20];
            app.Lamp_19.Color = [1 1 0.0667];

            % Create TextArea_19
            app.TextArea_19 = uitextarea(app.ResultEvaluationPanel_19);
            app.TextArea_19.Position = [5 3 352 50];

            % Create InfoPanel_19
            app.InfoPanel_19 = uipanel(app.GridLayout_19);
            app.InfoPanel_19.BorderType = 'none';
            app.InfoPanel_19.Title = 'Info.';
            app.InfoPanel_19.BackgroundColor = [1 1 1];
            app.InfoPanel_19.Layout.Row = 2;
            app.InfoPanel_19.Layout.Column = 2;
            app.InfoPanel_19.FontWeight = 'bold';

            % Create DatePicker_19
            app.DatePicker_19 = uidatepicker(app.InfoPanel_19);
            app.DatePicker_19.Position = [175 7 112 18];
            app.DatePicker_19.Value = datetime([2025 1 1]);

            % Create ProjectEditField_19Label
            app.ProjectEditField_19Label = uilabel(app.InfoPanel_19);
            app.ProjectEditField_19Label.HorizontalAlignment = 'right';
            app.ProjectEditField_19Label.Position = [4 57 46 22];
            app.ProjectEditField_19Label.Text = 'Project:';

            % Create ProjectEditField_19
            app.ProjectEditField_19 = uieditfield(app.InfoPanel_19, 'text');
            app.ProjectEditField_19.Position = [63 59 137 18];
            app.ProjectEditField_19.Value = 'Gestamp NRAC';

            % Create VersionEditField_19Label
            app.VersionEditField_19Label = uilabel(app.InfoPanel_19);
            app.VersionEditField_19Label.BackgroundColor = [1 1 1];
            app.VersionEditField_19Label.HorizontalAlignment = 'right';
            app.VersionEditField_19Label.Position = [4 31 48 22];
            app.VersionEditField_19Label.Text = 'Version:';

            % Create VersionEditField_19
            app.VersionEditField_19 = uieditfield(app.InfoPanel_19, 'text');
            app.VersionEditField_19.HorizontalAlignment = 'center';
            app.VersionEditField_19.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_19.Position = [63 34 77 17];
            app.VersionEditField_19.Value = 'G046';

            % Create FlexbodySwitch_19
            app.FlexbodySwitch_19 = uiswitch(app.InfoPanel_19, 'slider');
            app.FlexbodySwitch_19.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_19.FontSize = 9;
            app.FlexbodySwitch_19.Position = [219 34 35 16];
            app.FlexbodySwitch_19.Value = 'Flex-Off';

            % Create CreatorDropDown_19Label
            app.CreatorDropDown_19Label = uilabel(app.InfoPanel_19);
            app.CreatorDropDown_19Label.FontSize = 8;
            app.CreatorDropDown_19Label.Position = [8 4 50 22];
            app.CreatorDropDown_19Label.Text = 'Creator:';

            % Create CreatorDropDown_19
            app.CreatorDropDown_19 = uidropdown(app.InfoPanel_19);
            app.CreatorDropDown_19.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_19.FontSize = 8;
            app.CreatorDropDown_19.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_19.Position = [63 7 100 16];
            app.CreatorDropDown_19.Value = 'Q. Rong';

            % Create Image2_26
            app.Image2_26 = uiimage(app.InfoPanel_19);
            app.Image2_26.Position = [297 8 26 25];
            app.Image2_26.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_19
            app.Image9_19 = uiimage(app.InfoPanel_19);
            app.Image9_19.Position = [328 4 30 28];
            app.Image9_19.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create LateralForceTestLabel_2
            app.LateralForceTestLabel_2 = uilabel(app.InfoPanel_19);
            app.LateralForceTestLabel_2.BackgroundColor = [0.9294 0.6941 0.1255];
            app.LateralForceTestLabel_2.HorizontalAlignment = 'right';
            app.LateralForceTestLabel_2.FontWeight = 'bold';
            app.LateralForceTestLabel_2.Position = [219 55 139 22];
            app.LateralForceTestLabel_2.Text = 'Lateral Force Test';

            % Create LatForceComplianceWCTab
            app.LatForceComplianceWCTab = uitab(app.TabGroup_R_roll_results_2);
            app.LatForceComplianceWCTab.Title = 'Lat. Force Compliance @WC';
            app.LatForceComplianceWCTab.BackgroundColor = [1 1 1];

            % Create GridLayout_20
            app.GridLayout_20 = uigridlayout(app.LatForceComplianceWCTab);
            app.GridLayout_20.ColumnWidth = {'5x', '5x'};
            app.GridLayout_20.RowHeight = {'24x', '8x'};
            app.GridLayout_20.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_latcomp
            app.UIAxesLeft_R_latcomp = uiaxes(app.GridLayout_20);
            title(app.UIAxesLeft_R_latcomp, 'Title')
            xlabel(app.UIAxesLeft_R_latcomp, 'X')
            ylabel(app.UIAxesLeft_R_latcomp, 'Y')
            zlabel(app.UIAxesLeft_R_latcomp, 'Z')
            app.UIAxesLeft_R_latcomp.FontName = 'Times New Roman';
            app.UIAxesLeft_R_latcomp.XLim = [-4000 4000];
            app.UIAxesLeft_R_latcomp.FontSize = 10;
            app.UIAxesLeft_R_latcomp.Layout.Row = 1;
            app.UIAxesLeft_R_latcomp.Layout.Column = 1;

            % Create UIAxesRight_R_latcomp
            app.UIAxesRight_R_latcomp = uiaxes(app.GridLayout_20);
            title(app.UIAxesRight_R_latcomp, 'Title')
            xlabel(app.UIAxesRight_R_latcomp, 'X')
            ylabel(app.UIAxesRight_R_latcomp, 'Y')
            zlabel(app.UIAxesRight_R_latcomp, 'Z')
            app.UIAxesRight_R_latcomp.FontName = 'Times New Roman';
            app.UIAxesRight_R_latcomp.XLim = [-4000 4000];
            app.UIAxesRight_R_latcomp.FontSize = 10;
            app.UIAxesRight_R_latcomp.Layout.Row = 1;
            app.UIAxesRight_R_latcomp.Layout.Column = 2;

            % Create ResultEvaluationPanel_20
            app.ResultEvaluationPanel_20 = uipanel(app.GridLayout_20);
            app.ResultEvaluationPanel_20.BorderType = 'none';
            app.ResultEvaluationPanel_20.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_20.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_20.Layout.Row = 2;
            app.ResultEvaluationPanel_20.Layout.Column = 1;
            app.ResultEvaluationPanel_20.FontWeight = 'bold';

            % Create BewertungDropDown_20
            app.BewertungDropDown_20 = uidropdown(app.ResultEvaluationPanel_20);
            app.BewertungDropDown_20.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_20.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_20ValueChanged, true);
            app.BewertungDropDown_20.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_20.Position = [5 57 326 22];
            app.BewertungDropDown_20.Value = 'The current results need further optimization.';

            % Create Lamp_20
            app.Lamp_20 = uilamp(app.ResultEvaluationPanel_20);
            app.Lamp_20.Position = [336 58 20 20];
            app.Lamp_20.Color = [1 1 0.0667];

            % Create TextArea_20
            app.TextArea_20 = uitextarea(app.ResultEvaluationPanel_20);
            app.TextArea_20.Position = [5 3 352 50];

            % Create InfoPanel_20
            app.InfoPanel_20 = uipanel(app.GridLayout_20);
            app.InfoPanel_20.BorderType = 'none';
            app.InfoPanel_20.Title = 'Info.';
            app.InfoPanel_20.BackgroundColor = [1 1 1];
            app.InfoPanel_20.Layout.Row = 2;
            app.InfoPanel_20.Layout.Column = 2;
            app.InfoPanel_20.FontWeight = 'bold';

            % Create DatePicker_20
            app.DatePicker_20 = uidatepicker(app.InfoPanel_20);
            app.DatePicker_20.Position = [175 7 112 18];
            app.DatePicker_20.Value = datetime([2025 1 1]);

            % Create ProjectEditField_20Label
            app.ProjectEditField_20Label = uilabel(app.InfoPanel_20);
            app.ProjectEditField_20Label.HorizontalAlignment = 'right';
            app.ProjectEditField_20Label.Position = [4 57 46 22];
            app.ProjectEditField_20Label.Text = 'Project:';

            % Create ProjectEditField_20
            app.ProjectEditField_20 = uieditfield(app.InfoPanel_20, 'text');
            app.ProjectEditField_20.Position = [63 59 137 18];
            app.ProjectEditField_20.Value = 'Gestamp NRAC';

            % Create VersionEditField_20Label
            app.VersionEditField_20Label = uilabel(app.InfoPanel_20);
            app.VersionEditField_20Label.BackgroundColor = [1 1 1];
            app.VersionEditField_20Label.HorizontalAlignment = 'right';
            app.VersionEditField_20Label.Position = [4 31 48 22];
            app.VersionEditField_20Label.Text = 'Version:';

            % Create VersionEditField_20
            app.VersionEditField_20 = uieditfield(app.InfoPanel_20, 'text');
            app.VersionEditField_20.HorizontalAlignment = 'center';
            app.VersionEditField_20.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_20.Position = [63 34 77 17];
            app.VersionEditField_20.Value = 'G046';

            % Create FlexbodySwitch_20
            app.FlexbodySwitch_20 = uiswitch(app.InfoPanel_20, 'slider');
            app.FlexbodySwitch_20.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_20.FontSize = 9;
            app.FlexbodySwitch_20.Position = [219 34 35 16];
            app.FlexbodySwitch_20.Value = 'Flex-Off';

            % Create CreatorDropDown_20Label
            app.CreatorDropDown_20Label = uilabel(app.InfoPanel_20);
            app.CreatorDropDown_20Label.FontSize = 8;
            app.CreatorDropDown_20Label.Position = [8 4 50 22];
            app.CreatorDropDown_20Label.Text = 'Creator:';

            % Create CreatorDropDown_20
            app.CreatorDropDown_20 = uidropdown(app.InfoPanel_20);
            app.CreatorDropDown_20.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_20.FontSize = 8;
            app.CreatorDropDown_20.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_20.Position = [63 7 100 16];
            app.CreatorDropDown_20.Value = 'Q. Rong';

            % Create Image2_27
            app.Image2_27 = uiimage(app.InfoPanel_20);
            app.Image2_27.Position = [297 8 26 25];
            app.Image2_27.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_20
            app.Image9_20 = uiimage(app.InfoPanel_20);
            app.Image9_20.Position = [328 4 30 28];
            app.Image9_20.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create LateralForceTestLabel_3
            app.LateralForceTestLabel_3 = uilabel(app.InfoPanel_20);
            app.LateralForceTestLabel_3.BackgroundColor = [0.9294 0.6941 0.1255];
            app.LateralForceTestLabel_3.HorizontalAlignment = 'right';
            app.LateralForceTestLabel_3.FontWeight = 'bold';
            app.LateralForceTestLabel_3.Position = [219 55 139 22];
            app.LateralForceTestLabel_3.Text = 'Lateral Force Test';

            % Create LatSpinTab
            app.LatSpinTab = uitab(app.TabGroup_R_roll_results_2);
            app.LatSpinTab.Title = 'Lat. Spin';
            app.LatSpinTab.BackgroundColor = [1 1 1];

            % Create GridLayout_21
            app.GridLayout_21 = uigridlayout(app.LatSpinTab);
            app.GridLayout_21.ColumnWidth = {'5x', '5x'};
            app.GridLayout_21.RowHeight = {'24x', '8x'};
            app.GridLayout_21.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_latspin
            app.UIAxesLeft_R_latspin = uiaxes(app.GridLayout_21);
            title(app.UIAxesLeft_R_latspin, 'Title')
            xlabel(app.UIAxesLeft_R_latspin, 'X')
            ylabel(app.UIAxesLeft_R_latspin, 'Y')
            zlabel(app.UIAxesLeft_R_latspin, 'Z')
            app.UIAxesLeft_R_latspin.FontName = 'Times New Roman';
            app.UIAxesLeft_R_latspin.XLim = [-4000 4000];
            app.UIAxesLeft_R_latspin.FontSize = 10;
            app.UIAxesLeft_R_latspin.Layout.Row = 1;
            app.UIAxesLeft_R_latspin.Layout.Column = 1;

            % Create UIAxesRight_R_latspin
            app.UIAxesRight_R_latspin = uiaxes(app.GridLayout_21);
            title(app.UIAxesRight_R_latspin, 'Title')
            xlabel(app.UIAxesRight_R_latspin, 'X')
            ylabel(app.UIAxesRight_R_latspin, 'Y')
            zlabel(app.UIAxesRight_R_latspin, 'Z')
            app.UIAxesRight_R_latspin.FontName = 'Times New Roman';
            app.UIAxesRight_R_latspin.XLim = [-4000 4000];
            app.UIAxesRight_R_latspin.FontSize = 10;
            app.UIAxesRight_R_latspin.Layout.Row = 1;
            app.UIAxesRight_R_latspin.Layout.Column = 2;

            % Create ResultEvaluationPanel_21
            app.ResultEvaluationPanel_21 = uipanel(app.GridLayout_21);
            app.ResultEvaluationPanel_21.BorderType = 'none';
            app.ResultEvaluationPanel_21.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_21.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_21.Layout.Row = 2;
            app.ResultEvaluationPanel_21.Layout.Column = 1;
            app.ResultEvaluationPanel_21.FontWeight = 'bold';

            % Create BewertungDropDown_21
            app.BewertungDropDown_21 = uidropdown(app.ResultEvaluationPanel_21);
            app.BewertungDropDown_21.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_21.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_21ValueChanged, true);
            app.BewertungDropDown_21.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_21.Position = [5 57 326 22];
            app.BewertungDropDown_21.Value = 'The current results need further optimization.';

            % Create Lamp_21
            app.Lamp_21 = uilamp(app.ResultEvaluationPanel_21);
            app.Lamp_21.Position = [336 58 20 20];
            app.Lamp_21.Color = [1 1 0.0667];

            % Create TextArea_21
            app.TextArea_21 = uitextarea(app.ResultEvaluationPanel_21);
            app.TextArea_21.Position = [5 3 352 50];

            % Create InfoPanel_21
            app.InfoPanel_21 = uipanel(app.GridLayout_21);
            app.InfoPanel_21.BorderType = 'none';
            app.InfoPanel_21.Title = 'Info.';
            app.InfoPanel_21.BackgroundColor = [1 1 1];
            app.InfoPanel_21.Layout.Row = 2;
            app.InfoPanel_21.Layout.Column = 2;
            app.InfoPanel_21.FontWeight = 'bold';

            % Create DatePicker_21
            app.DatePicker_21 = uidatepicker(app.InfoPanel_21);
            app.DatePicker_21.Position = [175 7 112 18];
            app.DatePicker_21.Value = datetime([2025 1 1]);

            % Create ProjectEditField_21Label
            app.ProjectEditField_21Label = uilabel(app.InfoPanel_21);
            app.ProjectEditField_21Label.HorizontalAlignment = 'right';
            app.ProjectEditField_21Label.Position = [4 57 46 22];
            app.ProjectEditField_21Label.Text = 'Project:';

            % Create ProjectEditField_21
            app.ProjectEditField_21 = uieditfield(app.InfoPanel_21, 'text');
            app.ProjectEditField_21.Position = [63 59 137 18];
            app.ProjectEditField_21.Value = 'Gestamp NRAC';

            % Create VersionEditField_21Label
            app.VersionEditField_21Label = uilabel(app.InfoPanel_21);
            app.VersionEditField_21Label.BackgroundColor = [1 1 1];
            app.VersionEditField_21Label.HorizontalAlignment = 'right';
            app.VersionEditField_21Label.Position = [4 31 48 22];
            app.VersionEditField_21Label.Text = 'Version:';

            % Create VersionEditField_21
            app.VersionEditField_21 = uieditfield(app.InfoPanel_21, 'text');
            app.VersionEditField_21.HorizontalAlignment = 'center';
            app.VersionEditField_21.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_21.Position = [63 34 77 17];
            app.VersionEditField_21.Value = 'G046';

            % Create FlexbodySwitch_21
            app.FlexbodySwitch_21 = uiswitch(app.InfoPanel_21, 'slider');
            app.FlexbodySwitch_21.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_21.FontSize = 9;
            app.FlexbodySwitch_21.Position = [219 34 35 16];
            app.FlexbodySwitch_21.Value = 'Flex-Off';

            % Create CreatorDropDown_21Label
            app.CreatorDropDown_21Label = uilabel(app.InfoPanel_21);
            app.CreatorDropDown_21Label.FontSize = 8;
            app.CreatorDropDown_21Label.Position = [8 4 50 22];
            app.CreatorDropDown_21Label.Text = 'Creator:';

            % Create CreatorDropDown_21
            app.CreatorDropDown_21 = uidropdown(app.InfoPanel_21);
            app.CreatorDropDown_21.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_21.FontSize = 8;
            app.CreatorDropDown_21.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_21.Position = [63 7 100 16];
            app.CreatorDropDown_21.Value = 'Q. Rong';

            % Create Image2_28
            app.Image2_28 = uiimage(app.InfoPanel_21);
            app.Image2_28.Position = [297 8 26 25];
            app.Image2_28.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_21
            app.Image9_21 = uiimage(app.InfoPanel_21);
            app.Image9_21.Position = [328 4 30 28];
            app.Image9_21.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create LateralForceTestLabel_7
            app.LateralForceTestLabel_7 = uilabel(app.InfoPanel_21);
            app.LateralForceTestLabel_7.BackgroundColor = [0.9294 0.6941 0.1255];
            app.LateralForceTestLabel_7.HorizontalAlignment = 'right';
            app.LateralForceTestLabel_7.FontWeight = 'bold';
            app.LateralForceTestLabel_7.Position = [219 55 139 22];
            app.LateralForceTestLabel_7.Text = 'Lateral Force Test';

            % Create LatInclinationTab
            app.LatInclinationTab = uitab(app.TabGroup_R_roll_results_2);
            app.LatInclinationTab.Title = 'Lat. Inclination';
            app.LatInclinationTab.BackgroundColor = [1 1 1];

            % Create GridLayout_22
            app.GridLayout_22 = uigridlayout(app.LatInclinationTab);
            app.GridLayout_22.ColumnWidth = {'5x', '5x'};
            app.GridLayout_22.RowHeight = {'24x', '8x'};
            app.GridLayout_22.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_latinc
            app.UIAxesLeft_R_latinc = uiaxes(app.GridLayout_22);
            title(app.UIAxesLeft_R_latinc, 'Title')
            xlabel(app.UIAxesLeft_R_latinc, 'X')
            ylabel(app.UIAxesLeft_R_latinc, 'Y')
            zlabel(app.UIAxesLeft_R_latinc, 'Z')
            app.UIAxesLeft_R_latinc.FontName = 'Times New Roman';
            app.UIAxesLeft_R_latinc.XLim = [-4000 4000];
            app.UIAxesLeft_R_latinc.FontSize = 10;
            app.UIAxesLeft_R_latinc.Layout.Row = 1;
            app.UIAxesLeft_R_latinc.Layout.Column = 1;

            % Create UIAxesRight_R_latinc
            app.UIAxesRight_R_latinc = uiaxes(app.GridLayout_22);
            title(app.UIAxesRight_R_latinc, 'Title')
            xlabel(app.UIAxesRight_R_latinc, 'X')
            ylabel(app.UIAxesRight_R_latinc, 'Y')
            zlabel(app.UIAxesRight_R_latinc, 'Z')
            app.UIAxesRight_R_latinc.FontName = 'Times New Roman';
            app.UIAxesRight_R_latinc.XLim = [-4000 4000];
            app.UIAxesRight_R_latinc.FontSize = 10;
            app.UIAxesRight_R_latinc.Layout.Row = 1;
            app.UIAxesRight_R_latinc.Layout.Column = 2;

            % Create ResultEvaluationPanel_22
            app.ResultEvaluationPanel_22 = uipanel(app.GridLayout_22);
            app.ResultEvaluationPanel_22.BorderType = 'none';
            app.ResultEvaluationPanel_22.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_22.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_22.Layout.Row = 2;
            app.ResultEvaluationPanel_22.Layout.Column = 1;
            app.ResultEvaluationPanel_22.FontWeight = 'bold';

            % Create BewertungDropDown_22
            app.BewertungDropDown_22 = uidropdown(app.ResultEvaluationPanel_22);
            app.BewertungDropDown_22.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_22.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_22ValueChanged, true);
            app.BewertungDropDown_22.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_22.Position = [5 57 326 22];
            app.BewertungDropDown_22.Value = 'The current results need further optimization.';

            % Create Lamp_22
            app.Lamp_22 = uilamp(app.ResultEvaluationPanel_22);
            app.Lamp_22.Position = [336 58 20 20];
            app.Lamp_22.Color = [1 1 0.0667];

            % Create TextArea_22
            app.TextArea_22 = uitextarea(app.ResultEvaluationPanel_22);
            app.TextArea_22.Position = [5 3 352 50];

            % Create InfoPanel_22
            app.InfoPanel_22 = uipanel(app.GridLayout_22);
            app.InfoPanel_22.BorderType = 'none';
            app.InfoPanel_22.Title = 'Info.';
            app.InfoPanel_22.BackgroundColor = [1 1 1];
            app.InfoPanel_22.Layout.Row = 2;
            app.InfoPanel_22.Layout.Column = 2;
            app.InfoPanel_22.FontWeight = 'bold';

            % Create DatePicker_22
            app.DatePicker_22 = uidatepicker(app.InfoPanel_22);
            app.DatePicker_22.Position = [175 7 112 18];
            app.DatePicker_22.Value = datetime([2025 1 1]);

            % Create ProjectEditField_22Label
            app.ProjectEditField_22Label = uilabel(app.InfoPanel_22);
            app.ProjectEditField_22Label.HorizontalAlignment = 'right';
            app.ProjectEditField_22Label.Position = [4 57 46 22];
            app.ProjectEditField_22Label.Text = 'Project:';

            % Create ProjectEditField_22
            app.ProjectEditField_22 = uieditfield(app.InfoPanel_22, 'text');
            app.ProjectEditField_22.Position = [63 59 137 18];
            app.ProjectEditField_22.Value = 'Gestamp NRAC';

            % Create VersionEditField_22Label
            app.VersionEditField_22Label = uilabel(app.InfoPanel_22);
            app.VersionEditField_22Label.BackgroundColor = [1 1 1];
            app.VersionEditField_22Label.HorizontalAlignment = 'right';
            app.VersionEditField_22Label.Position = [4 31 48 22];
            app.VersionEditField_22Label.Text = 'Version:';

            % Create VersionEditField_22
            app.VersionEditField_22 = uieditfield(app.InfoPanel_22, 'text');
            app.VersionEditField_22.HorizontalAlignment = 'center';
            app.VersionEditField_22.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_22.Position = [63 34 77 17];
            app.VersionEditField_22.Value = 'G046';

            % Create FlexbodySwitch_22
            app.FlexbodySwitch_22 = uiswitch(app.InfoPanel_22, 'slider');
            app.FlexbodySwitch_22.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_22.FontSize = 9;
            app.FlexbodySwitch_22.Position = [219 34 35 16];
            app.FlexbodySwitch_22.Value = 'Flex-Off';

            % Create CreatorDropDown_22Label
            app.CreatorDropDown_22Label = uilabel(app.InfoPanel_22);
            app.CreatorDropDown_22Label.FontSize = 8;
            app.CreatorDropDown_22Label.Position = [8 4 50 22];
            app.CreatorDropDown_22Label.Text = 'Creator:';

            % Create CreatorDropDown_22
            app.CreatorDropDown_22 = uidropdown(app.InfoPanel_22);
            app.CreatorDropDown_22.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_22.FontSize = 8;
            app.CreatorDropDown_22.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_22.Position = [63 7 100 16];
            app.CreatorDropDown_22.Value = 'Q. Rong';

            % Create Image2_29
            app.Image2_29 = uiimage(app.InfoPanel_22);
            app.Image2_29.Position = [297 8 26 25];
            app.Image2_29.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_22
            app.Image9_22 = uiimage(app.InfoPanel_22);
            app.Image9_22.Position = [328 4 30 28];
            app.Image9_22.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create LateralForceTestLabel_6
            app.LateralForceTestLabel_6 = uilabel(app.InfoPanel_22);
            app.LateralForceTestLabel_6.BackgroundColor = [0.9294 0.6941 0.1255];
            app.LateralForceTestLabel_6.HorizontalAlignment = 'right';
            app.LateralForceTestLabel_6.FontWeight = 'bold';
            app.LateralForceTestLabel_6.Position = [219 55 139 22];
            app.LateralForceTestLabel_6.Text = 'Lateral Force Test';

            % Create LatScrubTab
            app.LatScrubTab = uitab(app.TabGroup_R_roll_results_2);
            app.LatScrubTab.Title = 'Lat. Scrub';
            app.LatScrubTab.BackgroundColor = [1 1 1];

            % Create GridLayout_23
            app.GridLayout_23 = uigridlayout(app.LatScrubTab);
            app.GridLayout_23.ColumnWidth = {'5x', '5x'};
            app.GridLayout_23.RowHeight = {'24x', '8x'};
            app.GridLayout_23.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_latsr
            app.UIAxesLeft_R_latsr = uiaxes(app.GridLayout_23);
            title(app.UIAxesLeft_R_latsr, 'Title')
            xlabel(app.UIAxesLeft_R_latsr, 'X')
            ylabel(app.UIAxesLeft_R_latsr, 'Y')
            zlabel(app.UIAxesLeft_R_latsr, 'Z')
            app.UIAxesLeft_R_latsr.FontName = 'Times New Roman';
            app.UIAxesLeft_R_latsr.XLim = [-4000 4000];
            app.UIAxesLeft_R_latsr.FontSize = 10;
            app.UIAxesLeft_R_latsr.Layout.Row = 1;
            app.UIAxesLeft_R_latsr.Layout.Column = 1;

            % Create UIAxesRight_R_latsr
            app.UIAxesRight_R_latsr = uiaxes(app.GridLayout_23);
            title(app.UIAxesRight_R_latsr, 'Title')
            xlabel(app.UIAxesRight_R_latsr, 'X')
            ylabel(app.UIAxesRight_R_latsr, 'Y')
            zlabel(app.UIAxesRight_R_latsr, 'Z')
            app.UIAxesRight_R_latsr.FontName = 'Times New Roman';
            app.UIAxesRight_R_latsr.XLim = [-4000 4000];
            app.UIAxesRight_R_latsr.FontSize = 10;
            app.UIAxesRight_R_latsr.Layout.Row = 1;
            app.UIAxesRight_R_latsr.Layout.Column = 2;

            % Create ResultEvaluationPanel_23
            app.ResultEvaluationPanel_23 = uipanel(app.GridLayout_23);
            app.ResultEvaluationPanel_23.BorderType = 'none';
            app.ResultEvaluationPanel_23.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_23.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_23.Layout.Row = 2;
            app.ResultEvaluationPanel_23.Layout.Column = 1;
            app.ResultEvaluationPanel_23.FontWeight = 'bold';

            % Create BewertungDropDown_23
            app.BewertungDropDown_23 = uidropdown(app.ResultEvaluationPanel_23);
            app.BewertungDropDown_23.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_23.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_23ValueChanged, true);
            app.BewertungDropDown_23.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_23.Position = [5 57 326 22];
            app.BewertungDropDown_23.Value = 'The current results need further optimization.';

            % Create Lamp_23
            app.Lamp_23 = uilamp(app.ResultEvaluationPanel_23);
            app.Lamp_23.Position = [336 58 20 20];
            app.Lamp_23.Color = [1 1 0];

            % Create TextArea_23
            app.TextArea_23 = uitextarea(app.ResultEvaluationPanel_23);
            app.TextArea_23.Position = [5 3 352 50];

            % Create InfoPanel_23
            app.InfoPanel_23 = uipanel(app.GridLayout_23);
            app.InfoPanel_23.BorderType = 'none';
            app.InfoPanel_23.Title = 'Info.';
            app.InfoPanel_23.BackgroundColor = [1 1 1];
            app.InfoPanel_23.Layout.Row = 2;
            app.InfoPanel_23.Layout.Column = 2;
            app.InfoPanel_23.FontWeight = 'bold';

            % Create DatePicker_23
            app.DatePicker_23 = uidatepicker(app.InfoPanel_23);
            app.DatePicker_23.Position = [175 7 112 18];
            app.DatePicker_23.Value = datetime([2025 1 1]);

            % Create ProjectEditField_23Label
            app.ProjectEditField_23Label = uilabel(app.InfoPanel_23);
            app.ProjectEditField_23Label.HorizontalAlignment = 'right';
            app.ProjectEditField_23Label.Position = [4 57 46 22];
            app.ProjectEditField_23Label.Text = 'Project:';

            % Create ProjectEditField_23
            app.ProjectEditField_23 = uieditfield(app.InfoPanel_23, 'text');
            app.ProjectEditField_23.Position = [63 59 137 18];
            app.ProjectEditField_23.Value = 'Gestamp NRAC';

            % Create VersionEditField_23Label
            app.VersionEditField_23Label = uilabel(app.InfoPanel_23);
            app.VersionEditField_23Label.BackgroundColor = [1 1 1];
            app.VersionEditField_23Label.HorizontalAlignment = 'right';
            app.VersionEditField_23Label.Position = [4 31 48 22];
            app.VersionEditField_23Label.Text = 'Version:';

            % Create VersionEditField_23
            app.VersionEditField_23 = uieditfield(app.InfoPanel_23, 'text');
            app.VersionEditField_23.HorizontalAlignment = 'center';
            app.VersionEditField_23.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_23.Position = [63 34 77 17];
            app.VersionEditField_23.Value = 'G046';

            % Create FlexbodySwitch_23
            app.FlexbodySwitch_23 = uiswitch(app.InfoPanel_23, 'slider');
            app.FlexbodySwitch_23.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_23.FontSize = 9;
            app.FlexbodySwitch_23.Position = [219 34 35 16];
            app.FlexbodySwitch_23.Value = 'Flex-Off';

            % Create Image2_30
            app.Image2_30 = uiimage(app.InfoPanel_23);
            app.Image2_30.Position = [297 8 26 25];
            app.Image2_30.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_23Label
            app.CreatorDropDown_23Label = uilabel(app.InfoPanel_23);
            app.CreatorDropDown_23Label.FontSize = 8;
            app.CreatorDropDown_23Label.Position = [8 4 50 22];
            app.CreatorDropDown_23Label.Text = 'Creator:';

            % Create CreatorDropDown_23
            app.CreatorDropDown_23 = uidropdown(app.InfoPanel_23);
            app.CreatorDropDown_23.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_23.FontSize = 8;
            app.CreatorDropDown_23.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_23.Position = [63 7 100 16];
            app.CreatorDropDown_23.Value = 'Q. Rong';

            % Create Image9_23
            app.Image9_23 = uiimage(app.InfoPanel_23);
            app.Image9_23.Position = [328 4 30 28];
            app.Image9_23.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create LateralForceTestLabel_4
            app.LateralForceTestLabel_4 = uilabel(app.InfoPanel_23);
            app.LateralForceTestLabel_4.BackgroundColor = [0.9294 0.6941 0.1255];
            app.LateralForceTestLabel_4.HorizontalAlignment = 'right';
            app.LateralForceTestLabel_4.FontWeight = 'bold';
            app.LateralForceTestLabel_4.Position = [219 55 139 22];
            app.LateralForceTestLabel_4.Text = 'Lateral Force Test';

            % Create LatCasterArmTab
            app.LatCasterArmTab = uitab(app.TabGroup_R_roll_results_2);
            app.LatCasterArmTab.Title = 'Lat. Caster Arm';

            % Create GridLayout_24
            app.GridLayout_24 = uigridlayout(app.LatCasterArmTab);
            app.GridLayout_24.ColumnWidth = {'5x', '5x'};
            app.GridLayout_24.RowHeight = {'24x', '8x'};
            app.GridLayout_24.BackgroundColor = [1 1 1];

            % Create UIAxesLeft_R_latcma
            app.UIAxesLeft_R_latcma = uiaxes(app.GridLayout_24);
            title(app.UIAxesLeft_R_latcma, 'Title')
            xlabel(app.UIAxesLeft_R_latcma, 'X')
            ylabel(app.UIAxesLeft_R_latcma, 'Y')
            zlabel(app.UIAxesLeft_R_latcma, 'Z')
            app.UIAxesLeft_R_latcma.FontName = 'Times New Roman';
            app.UIAxesLeft_R_latcma.XLim = [-4000 4000];
            app.UIAxesLeft_R_latcma.FontSize = 10;
            app.UIAxesLeft_R_latcma.Layout.Row = 1;
            app.UIAxesLeft_R_latcma.Layout.Column = 1;

            % Create UIAxesRight_R_latcma
            app.UIAxesRight_R_latcma = uiaxes(app.GridLayout_24);
            title(app.UIAxesRight_R_latcma, 'Title')
            xlabel(app.UIAxesRight_R_latcma, 'X')
            ylabel(app.UIAxesRight_R_latcma, 'Y')
            zlabel(app.UIAxesRight_R_latcma, 'Z')
            app.UIAxesRight_R_latcma.FontName = 'Times New Roman';
            app.UIAxesRight_R_latcma.XLim = [-4000 4000];
            app.UIAxesRight_R_latcma.FontSize = 10;
            app.UIAxesRight_R_latcma.Layout.Row = 1;
            app.UIAxesRight_R_latcma.Layout.Column = 2;

            % Create ResultEvaluationPanel_24
            app.ResultEvaluationPanel_24 = uipanel(app.GridLayout_24);
            app.ResultEvaluationPanel_24.BorderType = 'none';
            app.ResultEvaluationPanel_24.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_24.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_24.Layout.Row = 2;
            app.ResultEvaluationPanel_24.Layout.Column = 1;
            app.ResultEvaluationPanel_24.FontWeight = 'bold';

            % Create BewertungDropDown_24
            app.BewertungDropDown_24 = uidropdown(app.ResultEvaluationPanel_24);
            app.BewertungDropDown_24.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_24.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_24ValueChanged, true);
            app.BewertungDropDown_24.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_24.Position = [5 57 326 22];
            app.BewertungDropDown_24.Value = 'The current results need further optimization.';

            % Create Lamp_24
            app.Lamp_24 = uilamp(app.ResultEvaluationPanel_24);
            app.Lamp_24.Position = [336 58 20 20];
            app.Lamp_24.Color = [1 1 0.0667];

            % Create TextArea_24
            app.TextArea_24 = uitextarea(app.ResultEvaluationPanel_24);
            app.TextArea_24.Position = [5 3 352 50];

            % Create InfoPanel_24
            app.InfoPanel_24 = uipanel(app.GridLayout_24);
            app.InfoPanel_24.BorderType = 'none';
            app.InfoPanel_24.Title = 'Info.';
            app.InfoPanel_24.BackgroundColor = [1 1 1];
            app.InfoPanel_24.Layout.Row = 2;
            app.InfoPanel_24.Layout.Column = 2;
            app.InfoPanel_24.FontWeight = 'bold';

            % Create DatePicker_24
            app.DatePicker_24 = uidatepicker(app.InfoPanel_24);
            app.DatePicker_24.Position = [175 7 112 18];
            app.DatePicker_24.Value = datetime([2025 1 1]);

            % Create ProjectEditField_24Label
            app.ProjectEditField_24Label = uilabel(app.InfoPanel_24);
            app.ProjectEditField_24Label.HorizontalAlignment = 'right';
            app.ProjectEditField_24Label.Position = [4 57 46 22];
            app.ProjectEditField_24Label.Text = 'Project:';

            % Create ProjectEditField_24
            app.ProjectEditField_24 = uieditfield(app.InfoPanel_24, 'text');
            app.ProjectEditField_24.Position = [63 59 137 18];
            app.ProjectEditField_24.Value = 'Gestamp NRAC';

            % Create VersionEditField_24Label
            app.VersionEditField_24Label = uilabel(app.InfoPanel_24);
            app.VersionEditField_24Label.BackgroundColor = [1 1 1];
            app.VersionEditField_24Label.HorizontalAlignment = 'right';
            app.VersionEditField_24Label.Position = [4 31 48 22];
            app.VersionEditField_24Label.Text = 'Version:';

            % Create VersionEditField_24
            app.VersionEditField_24 = uieditfield(app.InfoPanel_24, 'text');
            app.VersionEditField_24.HorizontalAlignment = 'center';
            app.VersionEditField_24.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_24.Position = [63 34 77 17];
            app.VersionEditField_24.Value = 'G046';

            % Create FlexbodySwitch_24
            app.FlexbodySwitch_24 = uiswitch(app.InfoPanel_24, 'slider');
            app.FlexbodySwitch_24.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_24.FontSize = 9;
            app.FlexbodySwitch_24.Position = [219 34 35 16];
            app.FlexbodySwitch_24.Value = 'Flex-Off';

            % Create Image2_31
            app.Image2_31 = uiimage(app.InfoPanel_24);
            app.Image2_31.Position = [297 8 26 25];
            app.Image2_31.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_24Label
            app.CreatorDropDown_24Label = uilabel(app.InfoPanel_24);
            app.CreatorDropDown_24Label.FontSize = 8;
            app.CreatorDropDown_24Label.Position = [8 4 50 22];
            app.CreatorDropDown_24Label.Text = 'Creator:';

            % Create CreatorDropDown_24
            app.CreatorDropDown_24 = uidropdown(app.InfoPanel_24);
            app.CreatorDropDown_24.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_24.FontSize = 8;
            app.CreatorDropDown_24.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_24.Position = [63 7 100 16];
            app.CreatorDropDown_24.Value = 'Q. Rong';

            % Create Image9_24
            app.Image9_24 = uiimage(app.InfoPanel_24);
            app.Image9_24.Position = [328 4 30 28];
            app.Image9_24.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create LateralForceTestLabel_5
            app.LateralForceTestLabel_5 = uilabel(app.InfoPanel_24);
            app.LateralForceTestLabel_5.BackgroundColor = [0.9294 0.6941 0.1255];
            app.LateralForceTestLabel_5.HorizontalAlignment = 'right';
            app.LateralForceTestLabel_5.FontWeight = 'bold';
            app.LateralForceTestLabel_5.Position = [219 55 139 22];
            app.LateralForceTestLabel_5.Text = 'Lateral Force Test';

            % Create ResultsPanel_R_roll_2
            app.ResultsPanel_R_roll_2 = uipanel(app.Tab_KcRear_LateralForce);
            app.ResultsPanel_R_roll_2.BorderWidth = 0.5;
            app.ResultsPanel_R_roll_2.Title = 'Results';
            app.ResultsPanel_R_roll_2.BackgroundColor = [1 1 1];
            app.ResultsPanel_R_roll_2.FontName = 'Times New Roman';
            app.ResultsPanel_R_roll_2.Position = [19 11 275 468];

            % Create GridLayout3_2
            app.GridLayout3_2 = uigridlayout(app.ResultsPanel_R_roll_2);
            app.GridLayout3_2.ColumnWidth = {100, 55, 100};
            app.GridLayout3_2.RowHeight = {18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 20, '1x', 4};
            app.GridLayout3_2.ColumnSpacing = 4.5;
            app.GridLayout3_2.RowSpacing = 5.58823529411765;
            app.GridLayout3_2.Padding = [4.5 5.58823529411765 4.5 5.58823529411765];
            app.GridLayout3_2.BackgroundColor = [1 1 1];

            % Create Label_5
            app.Label_5 = uilabel(app.GridLayout3_2);
            app.Label_5.HorizontalAlignment = 'center';
            app.Label_5.FontName = 'Times New Roman';
            app.Label_5.FontSize = 8;
            app.Label_5.Layout.Row = 2;
            app.Label_5.Layout.Column = 3;
            app.Label_5.Text = '[-0.02 ~ +0.04]';

            % Create tbdLabel_8
            app.tbdLabel_8 = uilabel(app.GridLayout3_2);
            app.tbdLabel_8.HorizontalAlignment = 'center';
            app.tbdLabel_8.FontName = 'Times New Roman';
            app.tbdLabel_8.Layout.Row = 4;
            app.tbdLabel_8.Layout.Column = 3;
            app.tbdLabel_8.Text = '[t. b. d.]';

            % Create tbdLabel_9
            app.tbdLabel_9 = uilabel(app.GridLayout3_2);
            app.tbdLabel_9.HorizontalAlignment = 'center';
            app.tbdLabel_9.FontName = 'Times New Roman';
            app.tbdLabel_9.Layout.Row = 6;
            app.tbdLabel_9.Layout.Column = 3;
            app.tbdLabel_9.Text = '[t. b. d.]';

            % Create tbdLabel_10
            app.tbdLabel_10 = uilabel(app.GridLayout3_2);
            app.tbdLabel_10.HorizontalAlignment = 'center';
            app.tbdLabel_10.FontName = 'Times New Roman';
            app.tbdLabel_10.Layout.Row = 8;
            app.tbdLabel_10.Layout.Column = 3;
            app.tbdLabel_10.Text = '[t. b. d.]';

            % Create tbdLabel_11
            app.tbdLabel_11 = uilabel(app.GridLayout3_2);
            app.tbdLabel_11.HorizontalAlignment = 'center';
            app.tbdLabel_11.FontName = 'Times New Roman';
            app.tbdLabel_11.Layout.Row = 10;
            app.tbdLabel_11.Layout.Column = 3;
            app.tbdLabel_11.Text = '[t. b. d.]';

            % Create tbdLabel_12
            app.tbdLabel_12 = uilabel(app.GridLayout3_2);
            app.tbdLabel_12.HorizontalAlignment = 'center';
            app.tbdLabel_12.FontName = 'Times New Roman';
            app.tbdLabel_12.Layout.Row = 12;
            app.tbdLabel_12.Layout.Column = 3;
            app.tbdLabel_12.Text = '[t. b. d.]';

            % Create tbdLabel_13
            app.tbdLabel_13 = uilabel(app.GridLayout3_2);
            app.tbdLabel_13.HorizontalAlignment = 'center';
            app.tbdLabel_13.FontName = 'Times New Roman';
            app.tbdLabel_13.Layout.Row = 14;
            app.tbdLabel_13.Layout.Column = 3;
            app.tbdLabel_13.Text = '[t. b. d.]';

            % Create tbdLabel_14
            app.tbdLabel_14 = uilabel(app.GridLayout3_2);
            app.tbdLabel_14.HorizontalAlignment = 'center';
            app.tbdLabel_14.FontName = 'Times New Roman';
            app.tbdLabel_14.Layout.Row = 16;
            app.tbdLabel_14.Layout.Column = 3;
            app.tbdLabel_14.Text = '[t. b. d.]';

            % Create LatForceToeChangeLabel_2
            app.LatForceToeChangeLabel_2 = uilabel(app.GridLayout3_2);
            app.LatForceToeChangeLabel_2.VerticalAlignment = 'bottom';
            app.LatForceToeChangeLabel_2.FontName = 'Times New Roman';
            app.LatForceToeChangeLabel_2.Layout.Row = 1;
            app.LatForceToeChangeLabel_2.Layout.Column = [1 2];
            app.LatForceToeChangeLabel_2.Text = 'LatForce Toe Change';

            % Create lattoeEditField
            app.lattoeEditField = uieditfield(app.GridLayout3_2, 'numeric');
            app.lattoeEditField.FontName = 'Times New Roman';
            app.lattoeEditField.Layout.Row = 2;
            app.lattoeEditField.Layout.Column = 1;

            % Create LatForceToeChangeLabel
            app.LatForceToeChangeLabel = uilabel(app.GridLayout3_2);
            app.LatForceToeChangeLabel.VerticalAlignment = 'bottom';
            app.LatForceToeChangeLabel.FontName = 'Times New Roman';
            app.LatForceToeChangeLabel.Layout.Row = 3;
            app.LatForceToeChangeLabel.Layout.Column = [1 2];
            app.LatForceToeChangeLabel.Text = 'LatForceToe Change (1000N)';

            % Create lattoe1000EditField
            app.lattoe1000EditField = uieditfield(app.GridLayout3_2, 'numeric');
            app.lattoe1000EditField.FontName = 'Times New Roman';
            app.lattoe1000EditField.Layout.Row = 4;
            app.lattoe1000EditField.Layout.Column = 1;

            % Create LatForceCamberChangeEditFieldLabel
            app.LatForceCamberChangeEditFieldLabel = uilabel(app.GridLayout3_2);
            app.LatForceCamberChangeEditFieldLabel.VerticalAlignment = 'bottom';
            app.LatForceCamberChangeEditFieldLabel.FontName = 'Times New Roman';
            app.LatForceCamberChangeEditFieldLabel.Layout.Row = 5;
            app.LatForceCamberChangeEditFieldLabel.Layout.Column = [1 2];
            app.LatForceCamberChangeEditFieldLabel.Text = 'LatForce Camber Change';

            % Create latcamberEditField
            app.latcamberEditField = uieditfield(app.GridLayout3_2, 'numeric');
            app.latcamberEditField.FontName = 'Times New Roman';
            app.latcamberEditField.Layout.Row = 6;
            app.latcamberEditField.Layout.Column = 1;

            % Create LatForceComplianceWCLabel
            app.LatForceComplianceWCLabel = uilabel(app.GridLayout3_2);
            app.LatForceComplianceWCLabel.VerticalAlignment = 'bottom';
            app.LatForceComplianceWCLabel.FontName = 'Times New Roman';
            app.LatForceComplianceWCLabel.Layout.Row = 7;
            app.LatForceComplianceWCLabel.Layout.Column = [1 2];
            app.LatForceComplianceWCLabel.Text = 'LatForce Compliance @WC';

            % Create latcompEditField
            app.latcompEditField = uieditfield(app.GridLayout3_2, 'numeric');
            app.latcompEditField.FontName = 'Times New Roman';
            app.latcompEditField.Layout.Row = 8;
            app.latcompEditField.Layout.Column = 1;

            % Create KingpinCasterAngleLabel
            app.KingpinCasterAngleLabel = uilabel(app.GridLayout3_2);
            app.KingpinCasterAngleLabel.FontName = 'Times New Roman';
            app.KingpinCasterAngleLabel.Layout.Row = 9;
            app.KingpinCasterAngleLabel.Layout.Column = [1 2];
            app.KingpinCasterAngleLabel.Text = 'Kingpin Caster Angle';

            % Create latspinEditField
            app.latspinEditField = uieditfield(app.GridLayout3_2, 'numeric');
            app.latspinEditField.FontName = 'Times New Roman';
            app.latspinEditField.Layout.Row = 10;
            app.latspinEditField.Layout.Column = 1;

            % Create KingpinInclinationAngleLabel
            app.KingpinInclinationAngleLabel = uilabel(app.GridLayout3_2);
            app.KingpinInclinationAngleLabel.FontName = 'Times New Roman';
            app.KingpinInclinationAngleLabel.Layout.Row = 11;
            app.KingpinInclinationAngleLabel.Layout.Column = [1 2];
            app.KingpinInclinationAngleLabel.Text = 'Kingpin Inclination Angle';

            % Create latincEditField
            app.latincEditField = uieditfield(app.GridLayout3_2, 'numeric');
            app.latincEditField.FontName = 'Times New Roman';
            app.latincEditField.Layout.Row = 12;
            app.latincEditField.Layout.Column = 1;

            % Create ScrubRadiusLabel
            app.ScrubRadiusLabel = uilabel(app.GridLayout3_2);
            app.ScrubRadiusLabel.VerticalAlignment = 'bottom';
            app.ScrubRadiusLabel.FontName = 'Times New Roman';
            app.ScrubRadiusLabel.Layout.Row = 13;
            app.ScrubRadiusLabel.Layout.Column = [1 2];
            app.ScrubRadiusLabel.Text = 'Scrub Radius';

            % Create latsrEditField
            app.latsrEditField = uieditfield(app.GridLayout3_2, 'numeric');
            app.latsrEditField.FontName = 'Times New Roman';
            app.latsrEditField.Layout.Row = 14;
            app.latsrEditField.Layout.Column = 1;

            % Create CasterMomentArmLabel
            app.CasterMomentArmLabel = uilabel(app.GridLayout3_2);
            app.CasterMomentArmLabel.VerticalAlignment = 'bottom';
            app.CasterMomentArmLabel.FontName = 'Times New Roman';
            app.CasterMomentArmLabel.Layout.Row = 15;
            app.CasterMomentArmLabel.Layout.Column = 1;
            app.CasterMomentArmLabel.Text = 'Caster Moment Arm';

            % Create latcmaEditField
            app.latcmaEditField = uieditfield(app.GridLayout3_2, 'numeric');
            app.latcmaEditField.FontName = 'Times New Roman';
            app.latcmaEditField.Layout.Row = 16;
            app.latcmaEditField.Layout.Column = 1;

            % Create kNLabel
            app.kNLabel = uilabel(app.GridLayout3_2);
            app.kNLabel.HorizontalAlignment = 'center';
            app.kNLabel.FontName = 'Times New Roman';
            app.kNLabel.Layout.Row = 2;
            app.kNLabel.Layout.Column = 2;
            app.kNLabel.Text = '°/kN';

            % Create kNLabel_2
            app.kNLabel_2 = uilabel(app.GridLayout3_2);
            app.kNLabel_2.HorizontalAlignment = 'center';
            app.kNLabel_2.FontName = 'Times New Roman';
            app.kNLabel_2.Layout.Row = 4;
            app.kNLabel_2.Layout.Column = 2;
            app.kNLabel_2.Text = '°/kN';

            % Create kNLabel_3
            app.kNLabel_3 = uilabel(app.GridLayout3_2);
            app.kNLabel_3.HorizontalAlignment = 'center';
            app.kNLabel_3.FontName = 'Times New Roman';
            app.kNLabel_3.Layout.Row = 6;
            app.kNLabel_3.Layout.Column = 2;
            app.kNLabel_3.Text = '°/kN';

            % Create mmkNLabel
            app.mmkNLabel = uilabel(app.GridLayout3_2);
            app.mmkNLabel.HorizontalAlignment = 'center';
            app.mmkNLabel.FontName = 'Times New Roman';
            app.mmkNLabel.Layout.Row = 8;
            app.mmkNLabel.Layout.Column = 2;
            app.mmkNLabel.Text = 'mm/kN';

            % Create Label_6
            app.Label_6 = uilabel(app.GridLayout3_2);
            app.Label_6.HorizontalAlignment = 'center';
            app.Label_6.FontName = 'Times New Roman';
            app.Label_6.Layout.Row = 10;
            app.Label_6.Layout.Column = 2;
            app.Label_6.Text = '°';

            % Create Label_7
            app.Label_7 = uilabel(app.GridLayout3_2);
            app.Label_7.HorizontalAlignment = 'center';
            app.Label_7.FontName = 'Times New Roman';
            app.Label_7.Layout.Row = 12;
            app.Label_7.Layout.Column = 2;
            app.Label_7.Text = '°';

            % Create mmLabel_10
            app.mmLabel_10 = uilabel(app.GridLayout3_2);
            app.mmLabel_10.HorizontalAlignment = 'center';
            app.mmLabel_10.FontName = 'Times New Roman';
            app.mmLabel_10.Layout.Row = 14;
            app.mmLabel_10.Layout.Column = 2;
            app.mmLabel_10.Text = 'mm';

            % Create mmLabel_11
            app.mmLabel_11 = uilabel(app.GridLayout3_2);
            app.mmLabel_11.HorizontalAlignment = 'center';
            app.mmLabel_11.FontName = 'Times New Roman';
            app.mmLabel_11.Layout.Row = 16;
            app.mmLabel_11.Layout.Column = 2;
            app.mmLabel_11.Text = 'mm';

            % Create StatisticTargetButton_3
            app.StatisticTargetButton_3 = uibutton(app.GridLayout3_2, 'push');
            app.StatisticTargetButton_3.Layout.Row = 18;
            app.StatisticTargetButton_3.Layout.Column = 1;
            app.StatisticTargetButton_3.Text = 'Statistic Target';

            % Create LatClearAxesButton
            app.LatClearAxesButton = uibutton(app.GridLayout3_2, 'push');
            app.LatClearAxesButton.ButtonPushedFcn = createCallbackFcn(app, @LatClearAxesButtonPushed, true);
            app.LatClearAxesButton.Layout.Row = 18;
            app.LatClearAxesButton.Layout.Column = 3;
            app.LatClearAxesButton.Text = 'Plot Clear';

            % Create NRACTargetLabel_2
            app.NRACTargetLabel_2 = uilabel(app.GridLayout3_2);
            app.NRACTargetLabel_2.FontName = 'Times New Roman';
            app.NRACTargetLabel_2.Layout.Row = 1;
            app.NRACTargetLabel_2.Layout.Column = 3;
            app.NRACTargetLabel_2.Text = 'NRAC Target';

            % Create GOButton_R_lat
            app.GOButton_R_lat = uibutton(app.Tab_KcRear_LateralForce, 'push');
            app.GOButton_R_lat.ButtonPushedFcn = createCallbackFcn(app, @GOButton_R_latPushed, true);
            app.GOButton_R_lat.Tag = 'executeFunctionButton';
            app.GOButton_R_lat.Position = [740 500 100 23];
            app.GOButton_R_lat.Text = 'GO!';

            % Create Button_browser_R_lat
            app.Button_browser_R_lat = uibutton(app.Tab_KcRear_LateralForce, 'push');
            app.Button_browser_R_lat.ButtonPushedFcn = createCallbackFcn(app, @Button_browser_R_latPushed, true);
            app.Button_browser_R_lat.Tag = 'selectFileButton';
            app.Button_browser_R_lat.Position = [19 500 100 23];
            app.Button_browser_R_lat.Text = 'Select File ...';

            % Create CurrentFileLabel_3
            app.CurrentFileLabel_3 = uilabel(app.Tab_KcRear_LateralForce);
            app.CurrentFileLabel_3.HorizontalAlignment = 'right';
            app.CurrentFileLabel_3.Position = [124 500 70 22];
            app.CurrentFileLabel_3.Text = 'Current File:';

            % Create EditField_browser_R_lat
            app.EditField_browser_R_lat = uieditfield(app.Tab_KcRear_LateralForce, 'text');
            app.EditField_browser_R_lat.Tag = 'filePathEditField';
            app.EditField_browser_R_lat.Position = [209 500 512 22];

            % Create FittingRangeKnob_2Label_2
            app.FittingRangeKnob_2Label_2 = uilabel(app.Tab_KcRear_LateralForce);
            app.FittingRangeKnob_2Label_2.HorizontalAlignment = 'center';
            app.FittingRangeKnob_2Label_2.FontName = 'Times New Roman';
            app.FittingRangeKnob_2Label_2.FontSize = 8;
            app.FittingRangeKnob_2Label_2.Position = [866 512 77 22];
            app.FittingRangeKnob_2Label_2.Text = 'Fitting Range=';

            % Create FittingRangeKnob_R_lat
            app.FittingRangeKnob_R_lat = uiknob(app.Tab_KcRear_LateralForce, 'discrete');
            app.FittingRangeKnob_R_lat.Items = {'100', '200', '300', '400', '500'};
            app.FittingRangeKnob_R_lat.ValueChangedFcn = createCallbackFcn(app, @FittingRangeKnob_R_latValueChanged, true);
            app.FittingRangeKnob_R_lat.FontName = 'Times New Roman';
            app.FittingRangeKnob_R_lat.FontSize = 8;
            app.FittingRangeKnob_R_lat.Position = [1004 484 33 33];
            app.FittingRangeKnob_R_lat.Value = '500';

            % Create BYDDelphinButton_8
            app.BYDDelphinButton_8 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.BYDDelphinButton_8.Text = 'BYD Delphin';
            app.BYDDelphinButton_8.Position = [1075 430 88 23];

            % Create VWPassatButton_8
            app.VWPassatButton_8 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.VWPassatButton_8.Text = 'VW Passat';
            app.VWPassatButton_8.Position = [1075 404 88 23];

            % Create TeslaModel3Button_8
            app.TeslaModel3Button_8 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.TeslaModel3Button_8.Text = 'Tesla Model 3';
            app.TeslaModel3Button_8.Position = [1075 293 89 23];

            % Create FORDEDGEButton_8
            app.FORDEDGEButton_8 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.FORDEDGEButton_8.Text = 'FORD EDGE';
            app.FORDEDGEButton_8.Position = [1075 378 88 23];

            % Create RefVehicleLabel_8
            app.RefVehicleLabel_8 = uilabel(app.Tab_KcRear_LateralForce);
            app.RefVehicleLabel_8.FontWeight = 'bold';
            app.RefVehicleLabel_8.Position = [1081 510 72 22];
            app.RefVehicleLabel_8.Text = 'Ref. Vehicle';

            % Create ABDSPMMPlusLabel_7
            app.ABDSPMMPlusLabel_7 = uilabel(app.Tab_KcRear_LateralForce);
            app.ABDSPMMPlusLabel_7.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_7.FontSize = 10;
            app.ABDSPMMPlusLabel_7.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_7.Position = [1069 480 108 22];
            app.ABDSPMMPlusLabel_7.Text = '* ABD SPMM Plus';

            % Create TestBenchResultsLabel_3
            app.TestBenchResultsLabel_3 = uilabel(app.Tab_KcRear_LateralForce);
            app.TestBenchResultsLabel_3.FontName = 'Times New Roman';
            app.TestBenchResultsLabel_3.FontSize = 10;
            app.TestBenchResultsLabel_3.FontAngle = 'italic';
            app.TestBenchResultsLabel_3.Position = [1069 459 108 22];
            app.TestBenchResultsLabel_3.Text = '   Test Bench Results';

            % Create ABDSPMMPlusLabel_8
            app.ABDSPMMPlusLabel_8 = uilabel(app.Tab_KcRear_LateralForce);
            app.ABDSPMMPlusLabel_8.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_8.FontSize = 10;
            app.ABDSPMMPlusLabel_8.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_8.Position = [1069 343 108 22];
            app.ABDSPMMPlusLabel_8.Text = '* ABD SPMM Plus';

            % Create TestReportLabel_3
            app.TestReportLabel_3 = uilabel(app.Tab_KcRear_LateralForce);
            app.TestReportLabel_3.FontName = 'Times New Roman';
            app.TestReportLabel_3.FontSize = 10;
            app.TestReportLabel_3.FontAngle = 'italic';
            app.TestReportLabel_3.Position = [1069 322 108 22];
            app.TestReportLabel_3.Text = '   Test Report';

            % Create VWID3Button_3
            app.VWID3Button_3 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.VWID3Button_3.Text = 'VW ID.3';
            app.VWID3Button_3.Position = [1075 267 89 23];

            % Create BMW325iButton_3
            app.BMW325iButton_3 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.BMW325iButton_3.Text = 'BMW 325i';
            app.BMW325iButton_3.Position = [1075 241 89 23];

            % Create TOYOTAYarisButton_3
            app.TOYOTAYarisButton_3 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.TOYOTAYarisButton_3.Text = 'TOYOTA Yaris';
            app.TOYOTAYarisButton_3.Position = [1075 79 89 23];

            % Create BYDDolphinButton_3
            app.BYDDolphinButton_3 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.BYDDolphinButton_3.Text = 'BYD Dolphin';
            app.BYDDolphinButton_3.Position = [1075 157 89 23];

            % Create ABDSPMMPlusLabel_9
            app.ABDSPMMPlusLabel_9 = uilabel(app.Tab_KcRear_LateralForce);
            app.ABDSPMMPlusLabel_9.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_9.FontSize = 10;
            app.ABDSPMMPlusLabel_9.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_9.Position = [1069 207 108 22];
            app.ABDSPMMPlusLabel_9.Text = '* ABD SPMM Plus';

            % Create TwistBeamLabel_3
            app.TwistBeamLabel_3 = uilabel(app.Tab_KcRear_LateralForce);
            app.TwistBeamLabel_3.FontName = 'Times New Roman';
            app.TwistBeamLabel_3.FontSize = 10;
            app.TwistBeamLabel_3.FontAngle = 'italic';
            app.TwistBeamLabel_3.Position = [1069 186 108 22];
            app.TwistBeamLabel_3.Text = '   TwistBeam';

            % Create VWGolfButton_4
            app.VWGolfButton_4 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.VWGolfButton_4.Text = 'VW Golf';
            app.VWGolfButton_4.Position = [1075 131 89 23];

            % Create VWUPButton_3
            app.VWUPButton_3 = uibutton(app.Tab_KcRear_LateralForce, 'state');
            app.VWUPButton_3.Text = 'VW UP!';
            app.VWUPButton_3.Position = [1075 105 89 23];

            % Create Button_5
            app.Button_5 = uibutton(app.Tab_KcRear_LateralForce, 'push');
            app.Button_5.Icon = fullfile(pathToMLAPP, 'Icon_plot_custerm.png');
            app.Button_5.Position = [1075 11 40 41];
            app.Button_5.Text = '';

            % Create Button_6
            app.Button_6 = uibutton(app.Tab_KcRear_LateralForce, 'push');
            app.Button_6.Icon = fullfile(pathToMLAPP, 'icon_to_ppt.png');
            app.Button_6.Position = [1127 12 37 40];
            app.Button_6.Text = '';

            % Create Tab_KcRear_Braking
            app.Tab_KcRear_Braking = uitab(app.Tab_KcRear);
            app.Tab_KcRear_Braking.Title = 'Longitudinal Braking @CP';

            % Create EditField_R_braking_rangeshow
            app.EditField_R_braking_rangeshow = uieditfield(app.Tab_KcRear_Braking, 'numeric');
            app.EditField_R_braking_rangeshow.FontName = 'Times New Roman';
            app.EditField_R_braking_rangeshow.FontSize = 10;
            app.EditField_R_braking_rangeshow.Position = [871 491 46 18];
            app.EditField_R_braking_rangeshow.Value = 500;

            % Create mmLabel_R_braking_rangshow
            app.mmLabel_R_braking_rangshow = uilabel(app.Tab_KcRear_Braking);
            app.mmLabel_R_braking_rangshow.FontName = 'Times New Roman';
            app.mmLabel_R_braking_rangshow.Position = [918 489 43 22];
            app.mmLabel_R_braking_rangshow.Text = '* +/-1N';

            % Create TabGroup_R_braking_results
            app.TabGroup_R_braking_results = uitabgroup(app.Tab_KcRear_Braking);
            app.TabGroup_R_braking_results.Position = [304 10 756 468];

            % Create brakingSteerTab
            app.brakingSteerTab = uitab(app.TabGroup_R_braking_results);
            app.brakingSteerTab.Title = 'Braking Force Steer';
            app.brakingSteerTab.BackgroundColor = [1 1 1];

            % Create GridLayout_25
            app.GridLayout_25 = uigridlayout(app.brakingSteerTab);
            app.GridLayout_25.ColumnWidth = {'5x', '5x'};
            app.GridLayout_25.RowHeight = {'24x', '8x'};
            app.GridLayout_25.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_brakingtoe
            app.UIAxesRight_R_brakingtoe = uiaxes(app.GridLayout_25);
            title(app.UIAxesRight_R_brakingtoe, 'Title')
            xlabel(app.UIAxesRight_R_brakingtoe, 'X')
            ylabel(app.UIAxesRight_R_brakingtoe, 'Y')
            zlabel(app.UIAxesRight_R_brakingtoe, 'Z')
            app.UIAxesRight_R_brakingtoe.FontName = 'Times New Roman';
            app.UIAxesRight_R_brakingtoe.XLim = [-4000 4000];
            app.UIAxesRight_R_brakingtoe.FontSize = 10;
            app.UIAxesRight_R_brakingtoe.Layout.Row = 1;
            app.UIAxesRight_R_brakingtoe.Layout.Column = 2;

            % Create UIAxesLeft_R_brakingtoe
            app.UIAxesLeft_R_brakingtoe = uiaxes(app.GridLayout_25);
            title(app.UIAxesLeft_R_brakingtoe, 'Title')
            xlabel(app.UIAxesLeft_R_brakingtoe, 'X')
            ylabel(app.UIAxesLeft_R_brakingtoe, 'Y')
            zlabel(app.UIAxesLeft_R_brakingtoe, 'Z')
            app.UIAxesLeft_R_brakingtoe.FontName = 'Times New Roman';
            app.UIAxesLeft_R_brakingtoe.XLim = [-4000 4000];
            app.UIAxesLeft_R_brakingtoe.GridLineWidth = 0.1;
            app.UIAxesLeft_R_brakingtoe.MinorGridLineWidth = 0.1;
            app.UIAxesLeft_R_brakingtoe.GridAlpha = 0.1;
            app.UIAxesLeft_R_brakingtoe.FontSize = 10;
            app.UIAxesLeft_R_brakingtoe.Layout.Row = 1;
            app.UIAxesLeft_R_brakingtoe.Layout.Column = 1;

            % Create InfoPanel_25
            app.InfoPanel_25 = uipanel(app.GridLayout_25);
            app.InfoPanel_25.BorderType = 'none';
            app.InfoPanel_25.Title = 'Info.';
            app.InfoPanel_25.BackgroundColor = [1 1 1];
            app.InfoPanel_25.Layout.Row = 2;
            app.InfoPanel_25.Layout.Column = 2;
            app.InfoPanel_25.FontWeight = 'bold';

            % Create DatePicker_25
            app.DatePicker_25 = uidatepicker(app.InfoPanel_25);
            app.DatePicker_25.Position = [175 7 112 18];
            app.DatePicker_25.Value = datetime([2025 1 1]);

            % Create VersionEditField_25Label
            app.VersionEditField_25Label = uilabel(app.InfoPanel_25);
            app.VersionEditField_25Label.BackgroundColor = [1 1 1];
            app.VersionEditField_25Label.HorizontalAlignment = 'right';
            app.VersionEditField_25Label.Position = [4 32 48 22];
            app.VersionEditField_25Label.Text = 'Version:';

            % Create VersionEditField_25
            app.VersionEditField_25 = uieditfield(app.InfoPanel_25, 'text');
            app.VersionEditField_25.HorizontalAlignment = 'center';
            app.VersionEditField_25.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_25.Position = [63 34 77 17];
            app.VersionEditField_25.Value = 'G046';

            % Create FlexbodySwitch_25
            app.FlexbodySwitch_25 = uiswitch(app.InfoPanel_25, 'slider');
            app.FlexbodySwitch_25.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_25.FontSize = 9;
            app.FlexbodySwitch_25.Position = [219 34 35 16];
            app.FlexbodySwitch_25.Value = 'Flex-Off';

            % Create CreatorDropDown_25Label
            app.CreatorDropDown_25Label = uilabel(app.InfoPanel_25);
            app.CreatorDropDown_25Label.FontSize = 8;
            app.CreatorDropDown_25Label.Position = [8 5 50 22];
            app.CreatorDropDown_25Label.Text = 'Creator:';

            % Create CreatorDropDown_25
            app.CreatorDropDown_25 = uidropdown(app.InfoPanel_25);
            app.CreatorDropDown_25.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_25.FontSize = 8;
            app.CreatorDropDown_25.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_25.Position = [63 7 100 16];
            app.CreatorDropDown_25.Value = 'Q. Rong';

            % Create Image2_32
            app.Image2_32 = uiimage(app.InfoPanel_25);
            app.Image2_32.Position = [297 8 26 25];
            app.Image2_32.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_25
            app.Image9_25 = uiimage(app.InfoPanel_25);
            app.Image9_25.Position = [328 4 30 28];
            app.Image9_25.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BrakingForceTestLabel
            app.BrakingForceTestLabel = uilabel(app.InfoPanel_25);
            app.BrakingForceTestLabel.BackgroundColor = [0.4667 0.6745 0.1882];
            app.BrakingForceTestLabel.HorizontalAlignment = 'right';
            app.BrakingForceTestLabel.FontWeight = 'bold';
            app.BrakingForceTestLabel.Position = [219 55 139 22];
            app.BrakingForceTestLabel.Text = 'Braking Force Test';

            % Create ProjectEditField_26Label
            app.ProjectEditField_26Label = uilabel(app.InfoPanel_25);
            app.ProjectEditField_26Label.HorizontalAlignment = 'right';
            app.ProjectEditField_26Label.Position = [4 57 46 22];
            app.ProjectEditField_26Label.Text = 'Project:';

            % Create ProjectEditField_26
            app.ProjectEditField_26 = uieditfield(app.InfoPanel_25, 'text');
            app.ProjectEditField_26.Position = [63 59 137 18];
            app.ProjectEditField_26.Value = 'Gestamp NRAC';

            % Create ResultEvaluationPanel_25
            app.ResultEvaluationPanel_25 = uipanel(app.GridLayout_25);
            app.ResultEvaluationPanel_25.BorderType = 'none';
            app.ResultEvaluationPanel_25.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_25.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_25.Layout.Row = 2;
            app.ResultEvaluationPanel_25.Layout.Column = 1;
            app.ResultEvaluationPanel_25.FontWeight = 'bold';

            % Create BewertungDropDown_25
            app.BewertungDropDown_25 = uidropdown(app.ResultEvaluationPanel_25);
            app.BewertungDropDown_25.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_25.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_25ValueChanged, true);
            app.BewertungDropDown_25.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_25.Position = [5 57 326 22];
            app.BewertungDropDown_25.Value = 'The current results meet the requirements';

            % Create Lamp_25
            app.Lamp_25 = uilamp(app.ResultEvaluationPanel_25);
            app.Lamp_25.Position = [336 58 20 20];
            app.Lamp_25.Color = [1 1 0.0667];

            % Create TextArea_26
            app.TextArea_26 = uitextarea(app.ResultEvaluationPanel_25);
            app.TextArea_26.Position = [5 3 352 50];

            % Create brakingCamberTab
            app.brakingCamberTab = uitab(app.TabGroup_R_braking_results);
            app.brakingCamberTab.Title = 'Braking Force Camber';
            app.brakingCamberTab.BackgroundColor = [1 1 1];

            % Create GridLayout_26
            app.GridLayout_26 = uigridlayout(app.brakingCamberTab);
            app.GridLayout_26.ColumnWidth = {'5x', '5x'};
            app.GridLayout_26.RowHeight = {'24x', '8x'};
            app.GridLayout_26.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_brakingcamber
            app.UIAxesRight_R_brakingcamber = uiaxes(app.GridLayout_26);
            title(app.UIAxesRight_R_brakingcamber, 'Title')
            xlabel(app.UIAxesRight_R_brakingcamber, 'X')
            ylabel(app.UIAxesRight_R_brakingcamber, 'Y')
            zlabel(app.UIAxesRight_R_brakingcamber, 'Z')
            app.UIAxesRight_R_brakingcamber.FontName = 'Times New Roman';
            app.UIAxesRight_R_brakingcamber.XLim = [-4000 4000];
            app.UIAxesRight_R_brakingcamber.FontSize = 10;
            app.UIAxesRight_R_brakingcamber.Layout.Row = 1;
            app.UIAxesRight_R_brakingcamber.Layout.Column = 2;

            % Create UIAxesLeft_R_brakingcamber
            app.UIAxesLeft_R_brakingcamber = uiaxes(app.GridLayout_26);
            title(app.UIAxesLeft_R_brakingcamber, 'Title')
            xlabel(app.UIAxesLeft_R_brakingcamber, 'X')
            ylabel(app.UIAxesLeft_R_brakingcamber, 'Y')
            zlabel(app.UIAxesLeft_R_brakingcamber, 'Z')
            app.UIAxesLeft_R_brakingcamber.FontName = 'Times New Roman';
            app.UIAxesLeft_R_brakingcamber.XLim = [-4000 4000];
            app.UIAxesLeft_R_brakingcamber.FontSize = 10;
            app.UIAxesLeft_R_brakingcamber.Layout.Row = 1;
            app.UIAxesLeft_R_brakingcamber.Layout.Column = 1;

            % Create ResultEvaluationPanel_26
            app.ResultEvaluationPanel_26 = uipanel(app.GridLayout_26);
            app.ResultEvaluationPanel_26.BorderType = 'none';
            app.ResultEvaluationPanel_26.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_26.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_26.Layout.Row = 2;
            app.ResultEvaluationPanel_26.Layout.Column = 1;
            app.ResultEvaluationPanel_26.FontWeight = 'bold';

            % Create BewertungDropDown_26
            app.BewertungDropDown_26 = uidropdown(app.ResultEvaluationPanel_26);
            app.BewertungDropDown_26.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_26.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_26ValueChanged, true);
            app.BewertungDropDown_26.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_26.Position = [5 57 326 22];
            app.BewertungDropDown_26.Value = 'The current results meet the requirements';

            % Create Lamp_26
            app.Lamp_26 = uilamp(app.ResultEvaluationPanel_26);
            app.Lamp_26.Position = [336 58 20 20];
            app.Lamp_26.Color = [1 1 0.0667];

            % Create TextArea_27
            app.TextArea_27 = uitextarea(app.ResultEvaluationPanel_26);
            app.TextArea_27.Position = [5 3 352 50];

            % Create InfoPanel_26
            app.InfoPanel_26 = uipanel(app.GridLayout_26);
            app.InfoPanel_26.BorderType = 'none';
            app.InfoPanel_26.Title = 'Info.';
            app.InfoPanel_26.BackgroundColor = [1 1 1];
            app.InfoPanel_26.Layout.Row = 2;
            app.InfoPanel_26.Layout.Column = 2;
            app.InfoPanel_26.FontWeight = 'bold';

            % Create DatePicker_26
            app.DatePicker_26 = uidatepicker(app.InfoPanel_26);
            app.DatePicker_26.Position = [175 7 112 18];
            app.DatePicker_26.Value = datetime([2025 1 1]);

            % Create ProjectEditField_27Label
            app.ProjectEditField_27Label = uilabel(app.InfoPanel_26);
            app.ProjectEditField_27Label.HorizontalAlignment = 'right';
            app.ProjectEditField_27Label.Position = [4 57 46 22];
            app.ProjectEditField_27Label.Text = 'Project:';

            % Create ProjectEditField_27
            app.ProjectEditField_27 = uieditfield(app.InfoPanel_26, 'text');
            app.ProjectEditField_27.Position = [63 59 137 18];
            app.ProjectEditField_27.Value = 'Gestamp NRAC';

            % Create VersionEditField_26Label
            app.VersionEditField_26Label = uilabel(app.InfoPanel_26);
            app.VersionEditField_26Label.BackgroundColor = [1 1 1];
            app.VersionEditField_26Label.HorizontalAlignment = 'right';
            app.VersionEditField_26Label.Position = [4 31 48 22];
            app.VersionEditField_26Label.Text = 'Version:';

            % Create VersionEditField_26
            app.VersionEditField_26 = uieditfield(app.InfoPanel_26, 'text');
            app.VersionEditField_26.HorizontalAlignment = 'center';
            app.VersionEditField_26.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_26.Position = [63 34 77 17];
            app.VersionEditField_26.Value = 'G046';

            % Create FlexbodySwitch_26
            app.FlexbodySwitch_26 = uiswitch(app.InfoPanel_26, 'slider');
            app.FlexbodySwitch_26.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_26.FontSize = 9;
            app.FlexbodySwitch_26.Position = [219 34 35 16];
            app.FlexbodySwitch_26.Value = 'Flex-Off';

            % Create CreatorDropDown_26Label
            app.CreatorDropDown_26Label = uilabel(app.InfoPanel_26);
            app.CreatorDropDown_26Label.FontSize = 8;
            app.CreatorDropDown_26Label.Position = [8 4 50 22];
            app.CreatorDropDown_26Label.Text = 'Creator:';

            % Create CreatorDropDown_26
            app.CreatorDropDown_26 = uidropdown(app.InfoPanel_26);
            app.CreatorDropDown_26.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_26.FontSize = 8;
            app.CreatorDropDown_26.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_26.Position = [63 7 100 16];
            app.CreatorDropDown_26.Value = 'Q. Rong';

            % Create Image2_33
            app.Image2_33 = uiimage(app.InfoPanel_26);
            app.Image2_33.Position = [297 8 26 25];
            app.Image2_33.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_26
            app.Image9_26 = uiimage(app.InfoPanel_26);
            app.Image9_26.Position = [328 4 30 28];
            app.Image9_26.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BrakingForceTestLabel_2
            app.BrakingForceTestLabel_2 = uilabel(app.InfoPanel_26);
            app.BrakingForceTestLabel_2.BackgroundColor = [0.4667 0.6745 0.1882];
            app.BrakingForceTestLabel_2.HorizontalAlignment = 'right';
            app.BrakingForceTestLabel_2.FontWeight = 'bold';
            app.BrakingForceTestLabel_2.Position = [219 55 139 22];
            app.BrakingForceTestLabel_2.Text = 'Braking Force Test';

            % Create brakingComplianceWCTab
            app.brakingComplianceWCTab = uitab(app.TabGroup_R_braking_results);
            app.brakingComplianceWCTab.Title = 'Braking Force Compliance @WC';
            app.brakingComplianceWCTab.BackgroundColor = [1 1 1];

            % Create GridLayout_27
            app.GridLayout_27 = uigridlayout(app.brakingComplianceWCTab);
            app.GridLayout_27.ColumnWidth = {'5x', '5x'};
            app.GridLayout_27.RowHeight = {'24x', '8x'};
            app.GridLayout_27.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_brakingcomp
            app.UIAxesRight_R_brakingcomp = uiaxes(app.GridLayout_27);
            title(app.UIAxesRight_R_brakingcomp, 'Title')
            xlabel(app.UIAxesRight_R_brakingcomp, 'X')
            ylabel(app.UIAxesRight_R_brakingcomp, 'Y')
            zlabel(app.UIAxesRight_R_brakingcomp, 'Z')
            app.UIAxesRight_R_brakingcomp.FontName = 'Times New Roman';
            app.UIAxesRight_R_brakingcomp.XLim = [-4000 4000];
            app.UIAxesRight_R_brakingcomp.FontSize = 10;
            app.UIAxesRight_R_brakingcomp.Layout.Row = 1;
            app.UIAxesRight_R_brakingcomp.Layout.Column = 2;

            % Create UIAxesLeft_R_brakingcomp
            app.UIAxesLeft_R_brakingcomp = uiaxes(app.GridLayout_27);
            title(app.UIAxesLeft_R_brakingcomp, 'Title')
            xlabel(app.UIAxesLeft_R_brakingcomp, 'X')
            ylabel(app.UIAxesLeft_R_brakingcomp, 'Y')
            zlabel(app.UIAxesLeft_R_brakingcomp, 'Z')
            app.UIAxesLeft_R_brakingcomp.FontName = 'Times New Roman';
            app.UIAxesLeft_R_brakingcomp.XLim = [-4000 4000];
            app.UIAxesLeft_R_brakingcomp.FontSize = 10;
            app.UIAxesLeft_R_brakingcomp.Layout.Row = 1;
            app.UIAxesLeft_R_brakingcomp.Layout.Column = 1;

            % Create ResultEvaluationPanel_27
            app.ResultEvaluationPanel_27 = uipanel(app.GridLayout_27);
            app.ResultEvaluationPanel_27.BorderType = 'none';
            app.ResultEvaluationPanel_27.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_27.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_27.Layout.Row = 2;
            app.ResultEvaluationPanel_27.Layout.Column = 1;
            app.ResultEvaluationPanel_27.FontWeight = 'bold';

            % Create BewertungDropDown_27
            app.BewertungDropDown_27 = uidropdown(app.ResultEvaluationPanel_27);
            app.BewertungDropDown_27.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_27.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_27ValueChanged, true);
            app.BewertungDropDown_27.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_27.Position = [5 57 326 22];
            app.BewertungDropDown_27.Value = 'The current results meet the requirements';

            % Create Lamp_27
            app.Lamp_27 = uilamp(app.ResultEvaluationPanel_27);
            app.Lamp_27.Position = [336 58 20 20];
            app.Lamp_27.Color = [1 1 0.0667];

            % Create TextArea_28
            app.TextArea_28 = uitextarea(app.ResultEvaluationPanel_27);
            app.TextArea_28.Position = [5 3 352 50];

            % Create InfoPanel_27
            app.InfoPanel_27 = uipanel(app.GridLayout_27);
            app.InfoPanel_27.BorderType = 'none';
            app.InfoPanel_27.Title = 'Info.';
            app.InfoPanel_27.BackgroundColor = [1 1 1];
            app.InfoPanel_27.Layout.Row = 2;
            app.InfoPanel_27.Layout.Column = 2;
            app.InfoPanel_27.FontWeight = 'bold';

            % Create DatePicker_27
            app.DatePicker_27 = uidatepicker(app.InfoPanel_27);
            app.DatePicker_27.Position = [175 7 112 18];
            app.DatePicker_27.Value = datetime([2025 1 1]);

            % Create ProjectEditField_28Label
            app.ProjectEditField_28Label = uilabel(app.InfoPanel_27);
            app.ProjectEditField_28Label.HorizontalAlignment = 'right';
            app.ProjectEditField_28Label.Position = [4 57 46 22];
            app.ProjectEditField_28Label.Text = 'Project:';

            % Create ProjectEditField_28
            app.ProjectEditField_28 = uieditfield(app.InfoPanel_27, 'text');
            app.ProjectEditField_28.Position = [63 59 137 18];
            app.ProjectEditField_28.Value = 'Gestamp NRAC';

            % Create VersionEditField_27Label
            app.VersionEditField_27Label = uilabel(app.InfoPanel_27);
            app.VersionEditField_27Label.BackgroundColor = [1 1 1];
            app.VersionEditField_27Label.HorizontalAlignment = 'right';
            app.VersionEditField_27Label.Position = [4 31 48 22];
            app.VersionEditField_27Label.Text = 'Version:';

            % Create VersionEditField_27
            app.VersionEditField_27 = uieditfield(app.InfoPanel_27, 'text');
            app.VersionEditField_27.HorizontalAlignment = 'center';
            app.VersionEditField_27.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_27.Position = [63 34 77 17];
            app.VersionEditField_27.Value = 'G046';

            % Create FlexbodySwitch_27
            app.FlexbodySwitch_27 = uiswitch(app.InfoPanel_27, 'slider');
            app.FlexbodySwitch_27.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_27.FontSize = 9;
            app.FlexbodySwitch_27.Position = [219 34 35 16];
            app.FlexbodySwitch_27.Value = 'Flex-Off';

            % Create CreatorDropDown_27Label
            app.CreatorDropDown_27Label = uilabel(app.InfoPanel_27);
            app.CreatorDropDown_27Label.FontSize = 8;
            app.CreatorDropDown_27Label.Position = [8 4 50 22];
            app.CreatorDropDown_27Label.Text = 'Creator:';

            % Create CreatorDropDown_27
            app.CreatorDropDown_27 = uidropdown(app.InfoPanel_27);
            app.CreatorDropDown_27.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_27.FontSize = 8;
            app.CreatorDropDown_27.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_27.Position = [63 7 100 16];
            app.CreatorDropDown_27.Value = 'Q. Rong';

            % Create Image2_34
            app.Image2_34 = uiimage(app.InfoPanel_27);
            app.Image2_34.Position = [297 8 26 25];
            app.Image2_34.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_27
            app.Image9_27 = uiimage(app.InfoPanel_27);
            app.Image9_27.Position = [328 4 30 28];
            app.Image9_27.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BrakingForceTestLabel_3
            app.BrakingForceTestLabel_3 = uilabel(app.InfoPanel_27);
            app.BrakingForceTestLabel_3.BackgroundColor = [0.4667 0.6745 0.1882];
            app.BrakingForceTestLabel_3.HorizontalAlignment = 'right';
            app.BrakingForceTestLabel_3.FontWeight = 'bold';
            app.BrakingForceTestLabel_3.Position = [219 55 139 22];
            app.BrakingForceTestLabel_3.Text = 'Braking Force Test';

            % Create antiDiveTab
            app.antiDiveTab = uitab(app.TabGroup_R_braking_results);
            app.antiDiveTab.Title = 'anti-Dive';

            % Create GridLayout_32
            app.GridLayout_32 = uigridlayout(app.antiDiveTab);
            app.GridLayout_32.ColumnWidth = {'5x', '5x'};
            app.GridLayout_32.RowHeight = {'24x', '8x'};
            app.GridLayout_32.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_brakingantidive
            app.UIAxesRight_R_brakingantidive = uiaxes(app.GridLayout_32);
            title(app.UIAxesRight_R_brakingantidive, 'Title')
            xlabel(app.UIAxesRight_R_brakingantidive, 'X')
            ylabel(app.UIAxesRight_R_brakingantidive, 'Y')
            zlabel(app.UIAxesRight_R_brakingantidive, 'Z')
            app.UIAxesRight_R_brakingantidive.FontName = 'Times New Roman';
            app.UIAxesRight_R_brakingantidive.XLim = [-4000 4000];
            app.UIAxesRight_R_brakingantidive.FontSize = 10;
            app.UIAxesRight_R_brakingantidive.Layout.Row = 1;
            app.UIAxesRight_R_brakingantidive.Layout.Column = 2;

            % Create UIAxesLeft_R_brakingantidive
            app.UIAxesLeft_R_brakingantidive = uiaxes(app.GridLayout_32);
            title(app.UIAxesLeft_R_brakingantidive, 'Title')
            xlabel(app.UIAxesLeft_R_brakingantidive, 'X')
            ylabel(app.UIAxesLeft_R_brakingantidive, 'Y')
            zlabel(app.UIAxesLeft_R_brakingantidive, 'Z')
            app.UIAxesLeft_R_brakingantidive.FontName = 'Times New Roman';
            app.UIAxesLeft_R_brakingantidive.XLim = [-4000 4000];
            app.UIAxesLeft_R_brakingantidive.FontSize = 8;
            app.UIAxesLeft_R_brakingantidive.Layout.Row = 1;
            app.UIAxesLeft_R_brakingantidive.Layout.Column = 1;

            % Create ResultEvaluationPanel_32
            app.ResultEvaluationPanel_32 = uipanel(app.GridLayout_32);
            app.ResultEvaluationPanel_32.BorderType = 'none';
            app.ResultEvaluationPanel_32.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_32.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_32.Layout.Row = 2;
            app.ResultEvaluationPanel_32.Layout.Column = 1;
            app.ResultEvaluationPanel_32.FontWeight = 'bold';

            % Create BewertungDropDown_32
            app.BewertungDropDown_32 = uidropdown(app.ResultEvaluationPanel_32);
            app.BewertungDropDown_32.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_32.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_32ValueChanged, true);
            app.BewertungDropDown_32.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_32.Position = [5 57 326 22];
            app.BewertungDropDown_32.Value = 'The current results meet the requirements';

            % Create Lamp_32
            app.Lamp_32 = uilamp(app.ResultEvaluationPanel_32);
            app.Lamp_32.Position = [336 58 20 20];
            app.Lamp_32.Color = [1 1 0.0667];

            % Create TextArea_33
            app.TextArea_33 = uitextarea(app.ResultEvaluationPanel_32);
            app.TextArea_33.Position = [5 3 352 50];

            % Create InfoPanel_32
            app.InfoPanel_32 = uipanel(app.GridLayout_32);
            app.InfoPanel_32.BorderType = 'none';
            app.InfoPanel_32.Title = 'Info.';
            app.InfoPanel_32.BackgroundColor = [1 1 1];
            app.InfoPanel_32.Layout.Row = 2;
            app.InfoPanel_32.Layout.Column = 2;
            app.InfoPanel_32.FontWeight = 'bold';

            % Create DatePicker_32
            app.DatePicker_32 = uidatepicker(app.InfoPanel_32);
            app.DatePicker_32.Position = [175 7 112 18];
            app.DatePicker_32.Value = datetime([2025 1 1]);

            % Create ProjectEditField_33Label
            app.ProjectEditField_33Label = uilabel(app.InfoPanel_32);
            app.ProjectEditField_33Label.HorizontalAlignment = 'right';
            app.ProjectEditField_33Label.Position = [4 57 46 22];
            app.ProjectEditField_33Label.Text = 'Project:';

            % Create ProjectEditField_33
            app.ProjectEditField_33 = uieditfield(app.InfoPanel_32, 'text');
            app.ProjectEditField_33.Position = [63 59 137 18];
            app.ProjectEditField_33.Value = 'Gestamp NRAC';

            % Create VersionEditField_32Label
            app.VersionEditField_32Label = uilabel(app.InfoPanel_32);
            app.VersionEditField_32Label.BackgroundColor = [1 1 1];
            app.VersionEditField_32Label.HorizontalAlignment = 'right';
            app.VersionEditField_32Label.Position = [4 31 48 22];
            app.VersionEditField_32Label.Text = 'Version:';

            % Create VersionEditField_32
            app.VersionEditField_32 = uieditfield(app.InfoPanel_32, 'text');
            app.VersionEditField_32.HorizontalAlignment = 'center';
            app.VersionEditField_32.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_32.Position = [63 34 77 17];
            app.VersionEditField_32.Value = 'G046';

            % Create FlexbodySwitch_32
            app.FlexbodySwitch_32 = uiswitch(app.InfoPanel_32, 'slider');
            app.FlexbodySwitch_32.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_32.FontSize = 9;
            app.FlexbodySwitch_32.Position = [219 34 35 16];
            app.FlexbodySwitch_32.Value = 'Flex-Off';

            % Create Image2_39
            app.Image2_39 = uiimage(app.InfoPanel_32);
            app.Image2_39.Position = [297 8 26 25];
            app.Image2_39.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_32Label
            app.CreatorDropDown_32Label = uilabel(app.InfoPanel_32);
            app.CreatorDropDown_32Label.FontSize = 8;
            app.CreatorDropDown_32Label.Position = [8 4 50 22];
            app.CreatorDropDown_32Label.Text = 'Creator:';

            % Create CreatorDropDown_32
            app.CreatorDropDown_32 = uidropdown(app.InfoPanel_32);
            app.CreatorDropDown_32.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_32.FontSize = 8;
            app.CreatorDropDown_32.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_32.Position = [63 7 100 16];
            app.CreatorDropDown_32.Value = 'Q. Rong';

            % Create Image9_32
            app.Image9_32 = uiimage(app.InfoPanel_32);
            app.Image9_32.Position = [328 4 30 28];
            app.Image9_32.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BrakingForceTestLabel_8
            app.BrakingForceTestLabel_8 = uilabel(app.InfoPanel_32);
            app.BrakingForceTestLabel_8.BackgroundColor = [0.4667 0.6745 0.1882];
            app.BrakingForceTestLabel_8.HorizontalAlignment = 'right';
            app.BrakingForceTestLabel_8.FontWeight = 'bold';
            app.BrakingForceTestLabel_8.Position = [219 55 139 22];
            app.BrakingForceTestLabel_8.Text = 'Braking Force Test';

            % Create brakingSpinTab
            app.brakingSpinTab = uitab(app.TabGroup_R_braking_results);
            app.brakingSpinTab.Title = 'Braking Spin';
            app.brakingSpinTab.BackgroundColor = [1 1 1];

            % Create GridLayout_28
            app.GridLayout_28 = uigridlayout(app.brakingSpinTab);
            app.GridLayout_28.ColumnWidth = {'5x', '5x'};
            app.GridLayout_28.RowHeight = {'24x', '8x'};
            app.GridLayout_28.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_brakingspin
            app.UIAxesRight_R_brakingspin = uiaxes(app.GridLayout_28);
            title(app.UIAxesRight_R_brakingspin, 'Title')
            xlabel(app.UIAxesRight_R_brakingspin, 'X')
            ylabel(app.UIAxesRight_R_brakingspin, 'Y')
            zlabel(app.UIAxesRight_R_brakingspin, 'Z')
            app.UIAxesRight_R_brakingspin.FontName = 'Times New Roman';
            app.UIAxesRight_R_brakingspin.XLim = [-4000 4000];
            app.UIAxesRight_R_brakingspin.FontSize = 10;
            app.UIAxesRight_R_brakingspin.Layout.Row = 1;
            app.UIAxesRight_R_brakingspin.Layout.Column = 2;

            % Create UIAxesLeft_R_brakingspin
            app.UIAxesLeft_R_brakingspin = uiaxes(app.GridLayout_28);
            title(app.UIAxesLeft_R_brakingspin, 'Title')
            xlabel(app.UIAxesLeft_R_brakingspin, 'X')
            ylabel(app.UIAxesLeft_R_brakingspin, 'Y')
            zlabel(app.UIAxesLeft_R_brakingspin, 'Z')
            app.UIAxesLeft_R_brakingspin.FontName = 'Times New Roman';
            app.UIAxesLeft_R_brakingspin.XLim = [-4000 4000];
            app.UIAxesLeft_R_brakingspin.FontSize = 10;
            app.UIAxesLeft_R_brakingspin.Layout.Row = 1;
            app.UIAxesLeft_R_brakingspin.Layout.Column = 1;

            % Create ResultEvaluationPanel_28
            app.ResultEvaluationPanel_28 = uipanel(app.GridLayout_28);
            app.ResultEvaluationPanel_28.BorderType = 'none';
            app.ResultEvaluationPanel_28.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_28.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_28.Layout.Row = 2;
            app.ResultEvaluationPanel_28.Layout.Column = 1;
            app.ResultEvaluationPanel_28.FontWeight = 'bold';

            % Create BewertungDropDown_28
            app.BewertungDropDown_28 = uidropdown(app.ResultEvaluationPanel_28);
            app.BewertungDropDown_28.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_28.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_28ValueChanged, true);
            app.BewertungDropDown_28.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_28.Position = [5 57 326 22];
            app.BewertungDropDown_28.Value = 'The current results meet the requirements';

            % Create Lamp_28
            app.Lamp_28 = uilamp(app.ResultEvaluationPanel_28);
            app.Lamp_28.Position = [336 58 20 20];
            app.Lamp_28.Color = [1 1 0.0667];

            % Create TextArea_29
            app.TextArea_29 = uitextarea(app.ResultEvaluationPanel_28);
            app.TextArea_29.Position = [5 3 352 50];

            % Create InfoPanel_28
            app.InfoPanel_28 = uipanel(app.GridLayout_28);
            app.InfoPanel_28.BorderType = 'none';
            app.InfoPanel_28.Title = 'Info.';
            app.InfoPanel_28.BackgroundColor = [1 1 1];
            app.InfoPanel_28.Layout.Row = 2;
            app.InfoPanel_28.Layout.Column = 2;
            app.InfoPanel_28.FontWeight = 'bold';

            % Create DatePicker_28
            app.DatePicker_28 = uidatepicker(app.InfoPanel_28);
            app.DatePicker_28.Position = [175 7 112 18];
            app.DatePicker_28.Value = datetime([2025 1 1]);

            % Create ProjectEditField_29Label
            app.ProjectEditField_29Label = uilabel(app.InfoPanel_28);
            app.ProjectEditField_29Label.HorizontalAlignment = 'right';
            app.ProjectEditField_29Label.Position = [4 57 46 22];
            app.ProjectEditField_29Label.Text = 'Project:';

            % Create ProjectEditField_29
            app.ProjectEditField_29 = uieditfield(app.InfoPanel_28, 'text');
            app.ProjectEditField_29.Position = [63 59 137 18];
            app.ProjectEditField_29.Value = 'Gestamp NRAC';

            % Create VersionEditField_28Label
            app.VersionEditField_28Label = uilabel(app.InfoPanel_28);
            app.VersionEditField_28Label.BackgroundColor = [1 1 1];
            app.VersionEditField_28Label.HorizontalAlignment = 'right';
            app.VersionEditField_28Label.Position = [4 31 48 22];
            app.VersionEditField_28Label.Text = 'Version:';

            % Create VersionEditField_28
            app.VersionEditField_28 = uieditfield(app.InfoPanel_28, 'text');
            app.VersionEditField_28.HorizontalAlignment = 'center';
            app.VersionEditField_28.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_28.Position = [63 34 77 17];
            app.VersionEditField_28.Value = 'G046';

            % Create FlexbodySwitch_28
            app.FlexbodySwitch_28 = uiswitch(app.InfoPanel_28, 'slider');
            app.FlexbodySwitch_28.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_28.FontSize = 9;
            app.FlexbodySwitch_28.Position = [219 34 35 16];
            app.FlexbodySwitch_28.Value = 'Flex-Off';

            % Create CreatorDropDown_28Label
            app.CreatorDropDown_28Label = uilabel(app.InfoPanel_28);
            app.CreatorDropDown_28Label.FontSize = 8;
            app.CreatorDropDown_28Label.Position = [8 4 50 22];
            app.CreatorDropDown_28Label.Text = 'Creator:';

            % Create CreatorDropDown_28
            app.CreatorDropDown_28 = uidropdown(app.InfoPanel_28);
            app.CreatorDropDown_28.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_28.FontSize = 8;
            app.CreatorDropDown_28.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_28.Position = [63 7 100 16];
            app.CreatorDropDown_28.Value = 'Q. Rong';

            % Create Image2_35
            app.Image2_35 = uiimage(app.InfoPanel_28);
            app.Image2_35.Position = [297 8 26 25];
            app.Image2_35.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_28
            app.Image9_28 = uiimage(app.InfoPanel_28);
            app.Image9_28.Position = [328 4 30 28];
            app.Image9_28.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BrakingForceTestLabel_4
            app.BrakingForceTestLabel_4 = uilabel(app.InfoPanel_28);
            app.BrakingForceTestLabel_4.BackgroundColor = [0.4667 0.6745 0.1882];
            app.BrakingForceTestLabel_4.HorizontalAlignment = 'right';
            app.BrakingForceTestLabel_4.FontWeight = 'bold';
            app.BrakingForceTestLabel_4.Position = [219 55 139 22];
            app.BrakingForceTestLabel_4.Text = 'Braking Force Test';

            % Create brakingInclinationTab
            app.brakingInclinationTab = uitab(app.TabGroup_R_braking_results);
            app.brakingInclinationTab.Title = 'Braking. Inclination';
            app.brakingInclinationTab.BackgroundColor = [1 1 1];

            % Create GridLayout_29
            app.GridLayout_29 = uigridlayout(app.brakingInclinationTab);
            app.GridLayout_29.ColumnWidth = {'5x', '5x'};
            app.GridLayout_29.RowHeight = {'24x', '8x'};
            app.GridLayout_29.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_brakinginc
            app.UIAxesRight_R_brakinginc = uiaxes(app.GridLayout_29);
            title(app.UIAxesRight_R_brakinginc, 'Title')
            xlabel(app.UIAxesRight_R_brakinginc, 'X')
            ylabel(app.UIAxesRight_R_brakinginc, 'Y')
            zlabel(app.UIAxesRight_R_brakinginc, 'Z')
            app.UIAxesRight_R_brakinginc.FontName = 'Times New Roman';
            app.UIAxesRight_R_brakinginc.XLim = [-4000 4000];
            app.UIAxesRight_R_brakinginc.FontSize = 10;
            app.UIAxesRight_R_brakinginc.Layout.Row = 1;
            app.UIAxesRight_R_brakinginc.Layout.Column = 2;

            % Create UIAxesLeft_R_brakinginc
            app.UIAxesLeft_R_brakinginc = uiaxes(app.GridLayout_29);
            title(app.UIAxesLeft_R_brakinginc, 'Title')
            xlabel(app.UIAxesLeft_R_brakinginc, 'X')
            ylabel(app.UIAxesLeft_R_brakinginc, 'Y')
            zlabel(app.UIAxesLeft_R_brakinginc, 'Z')
            app.UIAxesLeft_R_brakinginc.FontName = 'Times New Roman';
            app.UIAxesLeft_R_brakinginc.XLim = [-4000 4000];
            app.UIAxesLeft_R_brakinginc.FontSize = 10;
            app.UIAxesLeft_R_brakinginc.Layout.Row = 1;
            app.UIAxesLeft_R_brakinginc.Layout.Column = 1;

            % Create ResultEvaluationPanel_29
            app.ResultEvaluationPanel_29 = uipanel(app.GridLayout_29);
            app.ResultEvaluationPanel_29.BorderType = 'none';
            app.ResultEvaluationPanel_29.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_29.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_29.Layout.Row = 2;
            app.ResultEvaluationPanel_29.Layout.Column = 1;
            app.ResultEvaluationPanel_29.FontWeight = 'bold';

            % Create BewertungDropDown_29
            app.BewertungDropDown_29 = uidropdown(app.ResultEvaluationPanel_29);
            app.BewertungDropDown_29.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_29.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_29ValueChanged, true);
            app.BewertungDropDown_29.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_29.Position = [5 57 326 22];
            app.BewertungDropDown_29.Value = 'The current results meet the requirements';

            % Create Lamp_29
            app.Lamp_29 = uilamp(app.ResultEvaluationPanel_29);
            app.Lamp_29.Position = [336 58 20 20];
            app.Lamp_29.Color = [1 1 0.0667];

            % Create TextArea_30
            app.TextArea_30 = uitextarea(app.ResultEvaluationPanel_29);
            app.TextArea_30.Position = [5 3 352 50];

            % Create InfoPanel_29
            app.InfoPanel_29 = uipanel(app.GridLayout_29);
            app.InfoPanel_29.BorderType = 'none';
            app.InfoPanel_29.Title = 'Info.';
            app.InfoPanel_29.BackgroundColor = [1 1 1];
            app.InfoPanel_29.Layout.Row = 2;
            app.InfoPanel_29.Layout.Column = 2;
            app.InfoPanel_29.FontWeight = 'bold';

            % Create DatePicker_29
            app.DatePicker_29 = uidatepicker(app.InfoPanel_29);
            app.DatePicker_29.Position = [175 7 112 18];
            app.DatePicker_29.Value = datetime([2025 1 1]);

            % Create ProjectEditField_30Label
            app.ProjectEditField_30Label = uilabel(app.InfoPanel_29);
            app.ProjectEditField_30Label.HorizontalAlignment = 'right';
            app.ProjectEditField_30Label.Position = [4 57 46 22];
            app.ProjectEditField_30Label.Text = 'Project:';

            % Create ProjectEditField_30
            app.ProjectEditField_30 = uieditfield(app.InfoPanel_29, 'text');
            app.ProjectEditField_30.Position = [63 59 137 18];
            app.ProjectEditField_30.Value = 'Gestamp NRAC';

            % Create VersionEditField_29Label
            app.VersionEditField_29Label = uilabel(app.InfoPanel_29);
            app.VersionEditField_29Label.BackgroundColor = [1 1 1];
            app.VersionEditField_29Label.HorizontalAlignment = 'right';
            app.VersionEditField_29Label.Position = [4 31 48 22];
            app.VersionEditField_29Label.Text = 'Version:';

            % Create VersionEditField_29
            app.VersionEditField_29 = uieditfield(app.InfoPanel_29, 'text');
            app.VersionEditField_29.HorizontalAlignment = 'center';
            app.VersionEditField_29.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_29.Position = [63 34 77 17];
            app.VersionEditField_29.Value = 'G046';

            % Create FlexbodySwitch_29
            app.FlexbodySwitch_29 = uiswitch(app.InfoPanel_29, 'slider');
            app.FlexbodySwitch_29.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_29.FontSize = 9;
            app.FlexbodySwitch_29.Position = [219 34 35 16];
            app.FlexbodySwitch_29.Value = 'Flex-Off';

            % Create CreatorDropDown_29Label
            app.CreatorDropDown_29Label = uilabel(app.InfoPanel_29);
            app.CreatorDropDown_29Label.FontSize = 8;
            app.CreatorDropDown_29Label.Position = [8 4 50 22];
            app.CreatorDropDown_29Label.Text = 'Creator:';

            % Create CreatorDropDown_29
            app.CreatorDropDown_29 = uidropdown(app.InfoPanel_29);
            app.CreatorDropDown_29.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_29.FontSize = 8;
            app.CreatorDropDown_29.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_29.Position = [63 7 100 16];
            app.CreatorDropDown_29.Value = 'Q. Rong';

            % Create Image2_36
            app.Image2_36 = uiimage(app.InfoPanel_29);
            app.Image2_36.Position = [297 8 26 25];
            app.Image2_36.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_29
            app.Image9_29 = uiimage(app.InfoPanel_29);
            app.Image9_29.Position = [328 4 30 28];
            app.Image9_29.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BrakingForceTestLabel_5
            app.BrakingForceTestLabel_5 = uilabel(app.InfoPanel_29);
            app.BrakingForceTestLabel_5.BackgroundColor = [0.4667 0.6745 0.1882];
            app.BrakingForceTestLabel_5.HorizontalAlignment = 'right';
            app.BrakingForceTestLabel_5.FontWeight = 'bold';
            app.BrakingForceTestLabel_5.Position = [219 55 139 22];
            app.BrakingForceTestLabel_5.Text = 'Braking Force Test';

            % Create brakingScrubTab
            app.brakingScrubTab = uitab(app.TabGroup_R_braking_results);
            app.brakingScrubTab.Title = 'Braking Scrub';
            app.brakingScrubTab.BackgroundColor = [1 1 1];

            % Create GridLayout_30
            app.GridLayout_30 = uigridlayout(app.brakingScrubTab);
            app.GridLayout_30.ColumnWidth = {'5x', '5x'};
            app.GridLayout_30.RowHeight = {'24x', '8x'};
            app.GridLayout_30.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_brakingsr
            app.UIAxesRight_R_brakingsr = uiaxes(app.GridLayout_30);
            title(app.UIAxesRight_R_brakingsr, 'Title')
            xlabel(app.UIAxesRight_R_brakingsr, 'X')
            ylabel(app.UIAxesRight_R_brakingsr, 'Y')
            zlabel(app.UIAxesRight_R_brakingsr, 'Z')
            app.UIAxesRight_R_brakingsr.FontName = 'Times New Roman';
            app.UIAxesRight_R_brakingsr.XLim = [-4000 4000];
            app.UIAxesRight_R_brakingsr.FontSize = 10;
            app.UIAxesRight_R_brakingsr.Layout.Row = 1;
            app.UIAxesRight_R_brakingsr.Layout.Column = 2;

            % Create UIAxesLeft_R_brakingsr
            app.UIAxesLeft_R_brakingsr = uiaxes(app.GridLayout_30);
            title(app.UIAxesLeft_R_brakingsr, 'Title')
            xlabel(app.UIAxesLeft_R_brakingsr, 'X')
            ylabel(app.UIAxesLeft_R_brakingsr, 'Y')
            zlabel(app.UIAxesLeft_R_brakingsr, 'Z')
            app.UIAxesLeft_R_brakingsr.FontName = 'Times New Roman';
            app.UIAxesLeft_R_brakingsr.XLim = [-4000 4000];
            app.UIAxesLeft_R_brakingsr.FontSize = 10;
            app.UIAxesLeft_R_brakingsr.Layout.Row = 1;
            app.UIAxesLeft_R_brakingsr.Layout.Column = 1;

            % Create ResultEvaluationPanel_30
            app.ResultEvaluationPanel_30 = uipanel(app.GridLayout_30);
            app.ResultEvaluationPanel_30.BorderType = 'none';
            app.ResultEvaluationPanel_30.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_30.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_30.Layout.Row = 2;
            app.ResultEvaluationPanel_30.Layout.Column = 1;
            app.ResultEvaluationPanel_30.FontWeight = 'bold';

            % Create BewertungDropDown_30
            app.BewertungDropDown_30 = uidropdown(app.ResultEvaluationPanel_30);
            app.BewertungDropDown_30.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_30.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_30ValueChanged, true);
            app.BewertungDropDown_30.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_30.Position = [5 57 326 22];
            app.BewertungDropDown_30.Value = 'The current results meet the requirements';

            % Create Lamp_30
            app.Lamp_30 = uilamp(app.ResultEvaluationPanel_30);
            app.Lamp_30.Position = [336 58 20 20];
            app.Lamp_30.Color = [1 1 0.0667];

            % Create TextArea_31
            app.TextArea_31 = uitextarea(app.ResultEvaluationPanel_30);
            app.TextArea_31.Position = [5 3 352 50];

            % Create InfoPanel_30
            app.InfoPanel_30 = uipanel(app.GridLayout_30);
            app.InfoPanel_30.BorderType = 'none';
            app.InfoPanel_30.Title = 'Info.';
            app.InfoPanel_30.BackgroundColor = [1 1 1];
            app.InfoPanel_30.Layout.Row = 2;
            app.InfoPanel_30.Layout.Column = 2;
            app.InfoPanel_30.FontWeight = 'bold';

            % Create DatePicker_30
            app.DatePicker_30 = uidatepicker(app.InfoPanel_30);
            app.DatePicker_30.Position = [175 7 112 18];
            app.DatePicker_30.Value = datetime([2025 1 1]);

            % Create ProjectEditField_31Label
            app.ProjectEditField_31Label = uilabel(app.InfoPanel_30);
            app.ProjectEditField_31Label.HorizontalAlignment = 'right';
            app.ProjectEditField_31Label.Position = [4 57 46 22];
            app.ProjectEditField_31Label.Text = 'Project:';

            % Create ProjectEditField_31
            app.ProjectEditField_31 = uieditfield(app.InfoPanel_30, 'text');
            app.ProjectEditField_31.Position = [63 59 137 18];
            app.ProjectEditField_31.Value = 'Gestamp NRAC';

            % Create VersionEditField_30Label
            app.VersionEditField_30Label = uilabel(app.InfoPanel_30);
            app.VersionEditField_30Label.BackgroundColor = [1 1 1];
            app.VersionEditField_30Label.HorizontalAlignment = 'right';
            app.VersionEditField_30Label.Position = [4 31 48 22];
            app.VersionEditField_30Label.Text = 'Version:';

            % Create VersionEditField_30
            app.VersionEditField_30 = uieditfield(app.InfoPanel_30, 'text');
            app.VersionEditField_30.HorizontalAlignment = 'center';
            app.VersionEditField_30.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_30.Position = [63 34 77 17];
            app.VersionEditField_30.Value = 'G046';

            % Create FlexbodySwitch_30
            app.FlexbodySwitch_30 = uiswitch(app.InfoPanel_30, 'slider');
            app.FlexbodySwitch_30.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_30.FontSize = 9;
            app.FlexbodySwitch_30.Position = [219 34 35 16];
            app.FlexbodySwitch_30.Value = 'Flex-Off';

            % Create Image2_37
            app.Image2_37 = uiimage(app.InfoPanel_30);
            app.Image2_37.Position = [297 8 26 25];
            app.Image2_37.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_30Label
            app.CreatorDropDown_30Label = uilabel(app.InfoPanel_30);
            app.CreatorDropDown_30Label.FontSize = 8;
            app.CreatorDropDown_30Label.Position = [8 4 50 22];
            app.CreatorDropDown_30Label.Text = 'Creator:';

            % Create CreatorDropDown_30
            app.CreatorDropDown_30 = uidropdown(app.InfoPanel_30);
            app.CreatorDropDown_30.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_30.FontSize = 8;
            app.CreatorDropDown_30.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_30.Position = [63 7 100 16];
            app.CreatorDropDown_30.Value = 'Q. Rong';

            % Create Image9_30
            app.Image9_30 = uiimage(app.InfoPanel_30);
            app.Image9_30.Position = [328 4 30 28];
            app.Image9_30.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BrakingForceTestLabel_6
            app.BrakingForceTestLabel_6 = uilabel(app.InfoPanel_30);
            app.BrakingForceTestLabel_6.BackgroundColor = [0.4667 0.6745 0.1882];
            app.BrakingForceTestLabel_6.HorizontalAlignment = 'right';
            app.BrakingForceTestLabel_6.FontWeight = 'bold';
            app.BrakingForceTestLabel_6.Position = [219 55 139 22];
            app.BrakingForceTestLabel_6.Text = 'Braking Force Test';

            % Create brakingCasterArmTab
            app.brakingCasterArmTab = uitab(app.TabGroup_R_braking_results);
            app.brakingCasterArmTab.Title = 'Braking Caster Arm';

            % Create GridLayout_31
            app.GridLayout_31 = uigridlayout(app.brakingCasterArmTab);
            app.GridLayout_31.ColumnWidth = {'5x', '5x'};
            app.GridLayout_31.RowHeight = {'24x', '8x'};
            app.GridLayout_31.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_brakingcma
            app.UIAxesRight_R_brakingcma = uiaxes(app.GridLayout_31);
            title(app.UIAxesRight_R_brakingcma, 'Title')
            xlabel(app.UIAxesRight_R_brakingcma, 'X')
            ylabel(app.UIAxesRight_R_brakingcma, 'Y')
            zlabel(app.UIAxesRight_R_brakingcma, 'Z')
            app.UIAxesRight_R_brakingcma.FontName = 'Times New Roman';
            app.UIAxesRight_R_brakingcma.XLim = [-4000 4000];
            app.UIAxesRight_R_brakingcma.FontSize = 10;
            app.UIAxesRight_R_brakingcma.Layout.Row = 1;
            app.UIAxesRight_R_brakingcma.Layout.Column = 2;

            % Create UIAxesLeft_R_brakingcma
            app.UIAxesLeft_R_brakingcma = uiaxes(app.GridLayout_31);
            title(app.UIAxesLeft_R_brakingcma, 'Title')
            xlabel(app.UIAxesLeft_R_brakingcma, 'X')
            ylabel(app.UIAxesLeft_R_brakingcma, 'Y')
            zlabel(app.UIAxesLeft_R_brakingcma, 'Z')
            app.UIAxesLeft_R_brakingcma.FontName = 'Times New Roman';
            app.UIAxesLeft_R_brakingcma.XLim = [-4000 4000];
            app.UIAxesLeft_R_brakingcma.FontSize = 10;
            app.UIAxesLeft_R_brakingcma.Layout.Row = 1;
            app.UIAxesLeft_R_brakingcma.Layout.Column = 1;

            % Create ResultEvaluationPanel_31
            app.ResultEvaluationPanel_31 = uipanel(app.GridLayout_31);
            app.ResultEvaluationPanel_31.BorderType = 'none';
            app.ResultEvaluationPanel_31.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_31.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_31.Layout.Row = 2;
            app.ResultEvaluationPanel_31.Layout.Column = 1;
            app.ResultEvaluationPanel_31.FontWeight = 'bold';

            % Create BewertungDropDown_31
            app.BewertungDropDown_31 = uidropdown(app.ResultEvaluationPanel_31);
            app.BewertungDropDown_31.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_31.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_31ValueChanged, true);
            app.BewertungDropDown_31.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_31.Position = [5 57 326 22];
            app.BewertungDropDown_31.Value = 'The current results meet the requirements';

            % Create Lamp_31
            app.Lamp_31 = uilamp(app.ResultEvaluationPanel_31);
            app.Lamp_31.Position = [336 58 20 20];
            app.Lamp_31.Color = [1 1 0.0667];

            % Create TextArea_32
            app.TextArea_32 = uitextarea(app.ResultEvaluationPanel_31);
            app.TextArea_32.Position = [5 3 352 50];

            % Create InfoPanel_31
            app.InfoPanel_31 = uipanel(app.GridLayout_31);
            app.InfoPanel_31.BorderType = 'none';
            app.InfoPanel_31.Title = 'Info.';
            app.InfoPanel_31.BackgroundColor = [1 1 1];
            app.InfoPanel_31.Layout.Row = 2;
            app.InfoPanel_31.Layout.Column = 2;
            app.InfoPanel_31.FontWeight = 'bold';

            % Create DatePicker_31
            app.DatePicker_31 = uidatepicker(app.InfoPanel_31);
            app.DatePicker_31.Position = [175 7 112 18];
            app.DatePicker_31.Value = datetime([2025 1 1]);

            % Create ProjectEditField_32Label
            app.ProjectEditField_32Label = uilabel(app.InfoPanel_31);
            app.ProjectEditField_32Label.HorizontalAlignment = 'right';
            app.ProjectEditField_32Label.Position = [4 57 46 22];
            app.ProjectEditField_32Label.Text = 'Project:';

            % Create ProjectEditField_32
            app.ProjectEditField_32 = uieditfield(app.InfoPanel_31, 'text');
            app.ProjectEditField_32.Position = [63 59 137 18];
            app.ProjectEditField_32.Value = 'Gestamp NRAC';

            % Create VersionEditField_31Label
            app.VersionEditField_31Label = uilabel(app.InfoPanel_31);
            app.VersionEditField_31Label.BackgroundColor = [1 1 1];
            app.VersionEditField_31Label.HorizontalAlignment = 'right';
            app.VersionEditField_31Label.Position = [4 31 48 22];
            app.VersionEditField_31Label.Text = 'Version:';

            % Create VersionEditField_31
            app.VersionEditField_31 = uieditfield(app.InfoPanel_31, 'text');
            app.VersionEditField_31.HorizontalAlignment = 'center';
            app.VersionEditField_31.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_31.Position = [63 34 77 17];
            app.VersionEditField_31.Value = 'G046';

            % Create FlexbodySwitch_31
            app.FlexbodySwitch_31 = uiswitch(app.InfoPanel_31, 'slider');
            app.FlexbodySwitch_31.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_31.FontSize = 9;
            app.FlexbodySwitch_31.Position = [219 34 35 16];
            app.FlexbodySwitch_31.Value = 'Flex-Off';

            % Create Image2_38
            app.Image2_38 = uiimage(app.InfoPanel_31);
            app.Image2_38.Position = [297 8 26 25];
            app.Image2_38.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_31Label
            app.CreatorDropDown_31Label = uilabel(app.InfoPanel_31);
            app.CreatorDropDown_31Label.FontSize = 8;
            app.CreatorDropDown_31Label.Position = [8 4 50 22];
            app.CreatorDropDown_31Label.Text = 'Creator:';

            % Create CreatorDropDown_31
            app.CreatorDropDown_31 = uidropdown(app.InfoPanel_31);
            app.CreatorDropDown_31.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_31.FontSize = 8;
            app.CreatorDropDown_31.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_31.Position = [63 7 100 16];
            app.CreatorDropDown_31.Value = 'Q. Rong';

            % Create Image9_31
            app.Image9_31 = uiimage(app.InfoPanel_31);
            app.Image9_31.Position = [328 4 30 28];
            app.Image9_31.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create BrakingForceTestLabel_7
            app.BrakingForceTestLabel_7 = uilabel(app.InfoPanel_31);
            app.BrakingForceTestLabel_7.BackgroundColor = [0.4667 0.6745 0.1882];
            app.BrakingForceTestLabel_7.HorizontalAlignment = 'right';
            app.BrakingForceTestLabel_7.FontWeight = 'bold';
            app.BrakingForceTestLabel_7.Position = [219 55 139 22];
            app.BrakingForceTestLabel_7.Text = 'Braking Force Test';

            % Create ResultsPanel_R_braking
            app.ResultsPanel_R_braking = uipanel(app.Tab_KcRear_Braking);
            app.ResultsPanel_R_braking.BorderWidth = 0.5;
            app.ResultsPanel_R_braking.Title = 'Results';
            app.ResultsPanel_R_braking.BackgroundColor = [1 1 1];
            app.ResultsPanel_R_braking.FontName = 'Times New Roman';
            app.ResultsPanel_R_braking.Position = [19 11 275 468];

            % Create GridLayout3_3
            app.GridLayout3_3 = uigridlayout(app.ResultsPanel_R_braking);
            app.GridLayout3_3.ColumnWidth = {100, 55, 100};
            app.GridLayout3_3.RowHeight = {18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 20, '1x', 4};
            app.GridLayout3_3.ColumnSpacing = 4.5;
            app.GridLayout3_3.RowSpacing = 5.58823529411765;
            app.GridLayout3_3.Padding = [4.5 5.58823529411765 4.5 5.58823529411765];
            app.GridLayout3_3.BackgroundColor = [1 1 1];

            % Create Label_8
            app.Label_8 = uilabel(app.GridLayout3_3);
            app.Label_8.HorizontalAlignment = 'center';
            app.Label_8.FontName = 'Times New Roman';
            app.Label_8.FontSize = 8;
            app.Label_8.Layout.Row = 2;
            app.Label_8.Layout.Column = 3;
            app.Label_8.Text = '[-0.02 ~ +0.04]';

            % Create tbdLabel_15
            app.tbdLabel_15 = uilabel(app.GridLayout3_3);
            app.tbdLabel_15.HorizontalAlignment = 'center';
            app.tbdLabel_15.FontName = 'Times New Roman';
            app.tbdLabel_15.Layout.Row = 4;
            app.tbdLabel_15.Layout.Column = 3;
            app.tbdLabel_15.Text = '[t. b. d.]';

            % Create tbdLabel_16
            app.tbdLabel_16 = uilabel(app.GridLayout3_3);
            app.tbdLabel_16.HorizontalAlignment = 'center';
            app.tbdLabel_16.FontName = 'Times New Roman';
            app.tbdLabel_16.Layout.Row = 6;
            app.tbdLabel_16.Layout.Column = 3;
            app.tbdLabel_16.Text = '[t. b. d.]';

            % Create tbdLabel_17
            app.tbdLabel_17 = uilabel(app.GridLayout3_3);
            app.tbdLabel_17.HorizontalAlignment = 'center';
            app.tbdLabel_17.FontName = 'Times New Roman';
            app.tbdLabel_17.Layout.Row = 8;
            app.tbdLabel_17.Layout.Column = 3;
            app.tbdLabel_17.Text = '[t. b. d.]';

            % Create tbdLabel_18
            app.tbdLabel_18 = uilabel(app.GridLayout3_3);
            app.tbdLabel_18.HorizontalAlignment = 'center';
            app.tbdLabel_18.FontName = 'Times New Roman';
            app.tbdLabel_18.Layout.Row = 10;
            app.tbdLabel_18.Layout.Column = 3;
            app.tbdLabel_18.Text = '[t. b. d.]';

            % Create tbdLabel_19
            app.tbdLabel_19 = uilabel(app.GridLayout3_3);
            app.tbdLabel_19.HorizontalAlignment = 'center';
            app.tbdLabel_19.FontName = 'Times New Roman';
            app.tbdLabel_19.Layout.Row = 12;
            app.tbdLabel_19.Layout.Column = 3;
            app.tbdLabel_19.Text = '[t. b. d.]';

            % Create tbdLabel_20
            app.tbdLabel_20 = uilabel(app.GridLayout3_3);
            app.tbdLabel_20.HorizontalAlignment = 'center';
            app.tbdLabel_20.FontName = 'Times New Roman';
            app.tbdLabel_20.Layout.Row = 14;
            app.tbdLabel_20.Layout.Column = 3;
            app.tbdLabel_20.Text = '[t. b. d.]';

            % Create tbdLabel_21
            app.tbdLabel_21 = uilabel(app.GridLayout3_3);
            app.tbdLabel_21.HorizontalAlignment = 'center';
            app.tbdLabel_21.FontName = 'Times New Roman';
            app.tbdLabel_21.Layout.Row = 16;
            app.tbdLabel_21.Layout.Column = 3;
            app.tbdLabel_21.Text = '[t. b. d.]';

            % Create LatForceToeChangeLabel_3
            app.LatForceToeChangeLabel_3 = uilabel(app.GridLayout3_3);
            app.LatForceToeChangeLabel_3.VerticalAlignment = 'bottom';
            app.LatForceToeChangeLabel_3.FontName = 'Times New Roman';
            app.LatForceToeChangeLabel_3.Layout.Row = 1;
            app.LatForceToeChangeLabel_3.Layout.Column = [1 2];
            app.LatForceToeChangeLabel_3.Text = 'Brake Steer Change';

            % Create brakingtoeEditField
            app.brakingtoeEditField = uieditfield(app.GridLayout3_3, 'numeric');
            app.brakingtoeEditField.FontName = 'Times New Roman';
            app.brakingtoeEditField.Layout.Row = 2;
            app.brakingtoeEditField.Layout.Column = 1;

            % Create LatForceToeChangeLabel_4
            app.LatForceToeChangeLabel_4 = uilabel(app.GridLayout3_3);
            app.LatForceToeChangeLabel_4.VerticalAlignment = 'bottom';
            app.LatForceToeChangeLabel_4.FontName = 'Times New Roman';
            app.LatForceToeChangeLabel_4.Layout.Row = 3;
            app.LatForceToeChangeLabel_4.Layout.Column = [1 2];
            app.LatForceToeChangeLabel_4.Text = 'Anti-Dive Angle';

            % Create brakingantidiveEditField
            app.brakingantidiveEditField = uieditfield(app.GridLayout3_3, 'numeric');
            app.brakingantidiveEditField.FontName = 'Times New Roman';
            app.brakingantidiveEditField.Layout.Row = 4;
            app.brakingantidiveEditField.Layout.Column = 1;

            % Create BrakeCamberChangeLabel
            app.BrakeCamberChangeLabel = uilabel(app.GridLayout3_3);
            app.BrakeCamberChangeLabel.VerticalAlignment = 'bottom';
            app.BrakeCamberChangeLabel.FontName = 'Times New Roman';
            app.BrakeCamberChangeLabel.Layout.Row = 5;
            app.BrakeCamberChangeLabel.Layout.Column = [1 2];
            app.BrakeCamberChangeLabel.Text = 'Brake Camber Change';

            % Create brakingcamberEditField
            app.brakingcamberEditField = uieditfield(app.GridLayout3_3, 'numeric');
            app.brakingcamberEditField.FontName = 'Times New Roman';
            app.brakingcamberEditField.Layout.Row = 6;
            app.brakingcamberEditField.Layout.Column = 1;

            % Create LatForceComplianceWCLabel_2
            app.LatForceComplianceWCLabel_2 = uilabel(app.GridLayout3_3);
            app.LatForceComplianceWCLabel_2.VerticalAlignment = 'bottom';
            app.LatForceComplianceWCLabel_2.FontName = 'Times New Roman';
            app.LatForceComplianceWCLabel_2.Layout.Row = 7;
            app.LatForceComplianceWCLabel_2.Layout.Column = [1 2];
            app.LatForceComplianceWCLabel_2.Text = 'Longitudinal Compliance @WC';

            % Create brakingcompEditField
            app.brakingcompEditField = uieditfield(app.GridLayout3_3, 'numeric');
            app.brakingcompEditField.FontName = 'Times New Roman';
            app.brakingcompEditField.Layout.Row = 8;
            app.brakingcompEditField.Layout.Column = 1;

            % Create KingpinCasterAngleLabel_2
            app.KingpinCasterAngleLabel_2 = uilabel(app.GridLayout3_3);
            app.KingpinCasterAngleLabel_2.FontName = 'Times New Roman';
            app.KingpinCasterAngleLabel_2.Layout.Row = 9;
            app.KingpinCasterAngleLabel_2.Layout.Column = [1 2];
            app.KingpinCasterAngleLabel_2.Text = 'Kingpin Caster Angle';

            % Create brakingspinEditField
            app.brakingspinEditField = uieditfield(app.GridLayout3_3, 'numeric');
            app.brakingspinEditField.FontName = 'Times New Roman';
            app.brakingspinEditField.Layout.Row = 10;
            app.brakingspinEditField.Layout.Column = 1;

            % Create KingpinInclinationAngleLabel_2
            app.KingpinInclinationAngleLabel_2 = uilabel(app.GridLayout3_3);
            app.KingpinInclinationAngleLabel_2.FontName = 'Times New Roman';
            app.KingpinInclinationAngleLabel_2.Layout.Row = 11;
            app.KingpinInclinationAngleLabel_2.Layout.Column = [1 2];
            app.KingpinInclinationAngleLabel_2.Text = 'Kingpin Inclination Angle';

            % Create brakingincEditField
            app.brakingincEditField = uieditfield(app.GridLayout3_3, 'numeric');
            app.brakingincEditField.FontName = 'Times New Roman';
            app.brakingincEditField.Layout.Row = 12;
            app.brakingincEditField.Layout.Column = 1;

            % Create ScrubRadiusLabel_2
            app.ScrubRadiusLabel_2 = uilabel(app.GridLayout3_3);
            app.ScrubRadiusLabel_2.VerticalAlignment = 'bottom';
            app.ScrubRadiusLabel_2.FontName = 'Times New Roman';
            app.ScrubRadiusLabel_2.Layout.Row = 13;
            app.ScrubRadiusLabel_2.Layout.Column = [1 2];
            app.ScrubRadiusLabel_2.Text = 'Scrub Radius';

            % Create brakingsrEditField
            app.brakingsrEditField = uieditfield(app.GridLayout3_3, 'numeric');
            app.brakingsrEditField.FontName = 'Times New Roman';
            app.brakingsrEditField.Layout.Row = 14;
            app.brakingsrEditField.Layout.Column = 1;

            % Create CasterMomentArmLabel_2
            app.CasterMomentArmLabel_2 = uilabel(app.GridLayout3_3);
            app.CasterMomentArmLabel_2.VerticalAlignment = 'bottom';
            app.CasterMomentArmLabel_2.FontName = 'Times New Roman';
            app.CasterMomentArmLabel_2.Layout.Row = 15;
            app.CasterMomentArmLabel_2.Layout.Column = 1;
            app.CasterMomentArmLabel_2.Text = 'Caster Moment Arm';

            % Create brakingcmaEditField
            app.brakingcmaEditField = uieditfield(app.GridLayout3_3, 'numeric');
            app.brakingcmaEditField.FontName = 'Times New Roman';
            app.brakingcmaEditField.Layout.Row = 16;
            app.brakingcmaEditField.Layout.Column = 1;

            % Create kNLabel_4
            app.kNLabel_4 = uilabel(app.GridLayout3_3);
            app.kNLabel_4.HorizontalAlignment = 'center';
            app.kNLabel_4.FontName = 'Times New Roman';
            app.kNLabel_4.Layout.Row = 2;
            app.kNLabel_4.Layout.Column = 2;
            app.kNLabel_4.Text = '°/kN';

            % Create Label_11
            app.Label_11 = uilabel(app.GridLayout3_3);
            app.Label_11.HorizontalAlignment = 'center';
            app.Label_11.FontName = 'Times New Roman';
            app.Label_11.Layout.Row = 4;
            app.Label_11.Layout.Column = 2;
            app.Label_11.Text = '°';

            % Create kNLabel_6
            app.kNLabel_6 = uilabel(app.GridLayout3_3);
            app.kNLabel_6.HorizontalAlignment = 'center';
            app.kNLabel_6.FontName = 'Times New Roman';
            app.kNLabel_6.Layout.Row = 6;
            app.kNLabel_6.Layout.Column = 2;
            app.kNLabel_6.Text = '°/kN';

            % Create mmkNLabel_2
            app.mmkNLabel_2 = uilabel(app.GridLayout3_3);
            app.mmkNLabel_2.HorizontalAlignment = 'center';
            app.mmkNLabel_2.FontName = 'Times New Roman';
            app.mmkNLabel_2.Layout.Row = 8;
            app.mmkNLabel_2.Layout.Column = 2;
            app.mmkNLabel_2.Text = 'mm/kN';

            % Create Label_9
            app.Label_9 = uilabel(app.GridLayout3_3);
            app.Label_9.HorizontalAlignment = 'center';
            app.Label_9.FontName = 'Times New Roman';
            app.Label_9.Layout.Row = 10;
            app.Label_9.Layout.Column = 2;
            app.Label_9.Text = '°';

            % Create Label_10
            app.Label_10 = uilabel(app.GridLayout3_3);
            app.Label_10.HorizontalAlignment = 'center';
            app.Label_10.FontName = 'Times New Roman';
            app.Label_10.Layout.Row = 12;
            app.Label_10.Layout.Column = 2;
            app.Label_10.Text = '°';

            % Create mmLabel_12
            app.mmLabel_12 = uilabel(app.GridLayout3_3);
            app.mmLabel_12.HorizontalAlignment = 'center';
            app.mmLabel_12.FontName = 'Times New Roman';
            app.mmLabel_12.Layout.Row = 14;
            app.mmLabel_12.Layout.Column = 2;
            app.mmLabel_12.Text = 'mm';

            % Create mmLabel_13
            app.mmLabel_13 = uilabel(app.GridLayout3_3);
            app.mmLabel_13.HorizontalAlignment = 'center';
            app.mmLabel_13.FontName = 'Times New Roman';
            app.mmLabel_13.Layout.Row = 16;
            app.mmLabel_13.Layout.Column = 2;
            app.mmLabel_13.Text = 'mm';

            % Create BrakingClearAxesButton
            app.BrakingClearAxesButton = uibutton(app.GridLayout3_3, 'push');
            app.BrakingClearAxesButton.ButtonPushedFcn = createCallbackFcn(app, @BrakingClearAxesButtonPushed, true);
            app.BrakingClearAxesButton.Layout.Row = 18;
            app.BrakingClearAxesButton.Layout.Column = 3;
            app.BrakingClearAxesButton.Text = 'Plot Clear';

            % Create PositivDirectionButton_4
            app.PositivDirectionButton_4 = uibutton(app.GridLayout3_3, 'push');
            app.PositivDirectionButton_4.Layout.Row = 18;
            app.PositivDirectionButton_4.Layout.Column = 1;
            app.PositivDirectionButton_4.Text = 'Positiv Direction';

            % Create NRACTargetLabel_3
            app.NRACTargetLabel_3 = uilabel(app.GridLayout3_3);
            app.NRACTargetLabel_3.FontName = 'Times New Roman';
            app.NRACTargetLabel_3.Layout.Row = 1;
            app.NRACTargetLabel_3.Layout.Column = 3;
            app.NRACTargetLabel_3.Text = 'NRAC Target';

            % Create GOButton_R_braking
            app.GOButton_R_braking = uibutton(app.Tab_KcRear_Braking, 'push');
            app.GOButton_R_braking.ButtonPushedFcn = createCallbackFcn(app, @GOButton_R_brakingPushed, true);
            app.GOButton_R_braking.Tag = 'executeFunctionButton';
            app.GOButton_R_braking.Position = [740 500 100 23];
            app.GOButton_R_braking.Text = 'GO!';

            % Create Button_browser_R_braking
            app.Button_browser_R_braking = uibutton(app.Tab_KcRear_Braking, 'push');
            app.Button_browser_R_braking.ButtonPushedFcn = createCallbackFcn(app, @Button_browser_R_brakingPushed, true);
            app.Button_browser_R_braking.Tag = 'selectFileButton';
            app.Button_browser_R_braking.Position = [19 500 100 23];
            app.Button_browser_R_braking.Text = 'Select File ...';

            % Create CurrentFileLabel_4
            app.CurrentFileLabel_4 = uilabel(app.Tab_KcRear_Braking);
            app.CurrentFileLabel_4.HorizontalAlignment = 'right';
            app.CurrentFileLabel_4.Position = [124 500 70 22];
            app.CurrentFileLabel_4.Text = 'Current File:';

            % Create EditField_browser_R_braking
            app.EditField_browser_R_braking = uieditfield(app.Tab_KcRear_Braking, 'text');
            app.EditField_browser_R_braking.Tag = 'filePathEditField';
            app.EditField_browser_R_braking.Position = [209 500 512 22];

            % Create FittingRangeKnob_2Label_3
            app.FittingRangeKnob_2Label_3 = uilabel(app.Tab_KcRear_Braking);
            app.FittingRangeKnob_2Label_3.HorizontalAlignment = 'center';
            app.FittingRangeKnob_2Label_3.FontName = 'Times New Roman';
            app.FittingRangeKnob_2Label_3.FontSize = 8;
            app.FittingRangeKnob_2Label_3.Position = [866 512 77 22];
            app.FittingRangeKnob_2Label_3.Text = 'Fitting Range=';

            % Create FittingRangeKnob_R_braking
            app.FittingRangeKnob_R_braking = uiknob(app.Tab_KcRear_Braking, 'discrete');
            app.FittingRangeKnob_R_braking.Items = {'100', '200', '300', '400', '500'};
            app.FittingRangeKnob_R_braking.ValueChangedFcn = createCallbackFcn(app, @FittingRangeKnob_R_brakingValueChanged, true);
            app.FittingRangeKnob_R_braking.FontName = 'Times New Roman';
            app.FittingRangeKnob_R_braking.FontSize = 8;
            app.FittingRangeKnob_R_braking.Position = [1004 484 33 33];
            app.FittingRangeKnob_R_braking.Value = '500';

            % Create BYDDelphinButton_9
            app.BYDDelphinButton_9 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.BYDDelphinButton_9.Text = 'BYD Delphin';
            app.BYDDelphinButton_9.Position = [1075 430 88 23];

            % Create VWPassatButton_9
            app.VWPassatButton_9 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.VWPassatButton_9.Text = 'VW Passat';
            app.VWPassatButton_9.Position = [1075 404 88 23];

            % Create TeslaModel3Button_9
            app.TeslaModel3Button_9 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.TeslaModel3Button_9.Text = 'Tesla Model 3';
            app.TeslaModel3Button_9.Position = [1075 293 89 23];

            % Create FORDEDGEButton_9
            app.FORDEDGEButton_9 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.FORDEDGEButton_9.Text = 'FORD EDGE';
            app.FORDEDGEButton_9.Position = [1075 378 88 23];

            % Create RefVehicleLabel_9
            app.RefVehicleLabel_9 = uilabel(app.Tab_KcRear_Braking);
            app.RefVehicleLabel_9.FontWeight = 'bold';
            app.RefVehicleLabel_9.Position = [1081 510 72 22];
            app.RefVehicleLabel_9.Text = 'Ref. Vehicle';

            % Create ABDSPMMPlusLabel_10
            app.ABDSPMMPlusLabel_10 = uilabel(app.Tab_KcRear_Braking);
            app.ABDSPMMPlusLabel_10.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_10.FontSize = 10;
            app.ABDSPMMPlusLabel_10.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_10.Position = [1069 480 108 22];
            app.ABDSPMMPlusLabel_10.Text = '* ABD SPMM Plus';

            % Create TestBenchResultsLabel_4
            app.TestBenchResultsLabel_4 = uilabel(app.Tab_KcRear_Braking);
            app.TestBenchResultsLabel_4.FontName = 'Times New Roman';
            app.TestBenchResultsLabel_4.FontSize = 10;
            app.TestBenchResultsLabel_4.FontAngle = 'italic';
            app.TestBenchResultsLabel_4.Position = [1069 459 108 22];
            app.TestBenchResultsLabel_4.Text = '   Test Bench Results';

            % Create ABDSPMMPlusLabel_11
            app.ABDSPMMPlusLabel_11 = uilabel(app.Tab_KcRear_Braking);
            app.ABDSPMMPlusLabel_11.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_11.FontSize = 10;
            app.ABDSPMMPlusLabel_11.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_11.Position = [1069 343 108 22];
            app.ABDSPMMPlusLabel_11.Text = '* ABD SPMM Plus';

            % Create TestReportLabel_4
            app.TestReportLabel_4 = uilabel(app.Tab_KcRear_Braking);
            app.TestReportLabel_4.FontName = 'Times New Roman';
            app.TestReportLabel_4.FontSize = 10;
            app.TestReportLabel_4.FontAngle = 'italic';
            app.TestReportLabel_4.Position = [1069 322 108 22];
            app.TestReportLabel_4.Text = '   Test Report';

            % Create VWID3Button_4
            app.VWID3Button_4 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.VWID3Button_4.Text = 'VW ID.3';
            app.VWID3Button_4.Position = [1075 267 89 23];

            % Create BMW325iButton_4
            app.BMW325iButton_4 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.BMW325iButton_4.Text = 'BMW 325i';
            app.BMW325iButton_4.Position = [1075 241 89 23];

            % Create TOYOTAYarisButton_4
            app.TOYOTAYarisButton_4 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.TOYOTAYarisButton_4.Text = 'TOYOTA Yaris';
            app.TOYOTAYarisButton_4.Position = [1075 79 89 23];

            % Create BYDDolphinButton_4
            app.BYDDolphinButton_4 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.BYDDolphinButton_4.Text = 'BYD Dolphin';
            app.BYDDolphinButton_4.Position = [1075 157 89 23];

            % Create ABDSPMMPlusLabel_12
            app.ABDSPMMPlusLabel_12 = uilabel(app.Tab_KcRear_Braking);
            app.ABDSPMMPlusLabel_12.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_12.FontSize = 10;
            app.ABDSPMMPlusLabel_12.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_12.Position = [1069 207 108 22];
            app.ABDSPMMPlusLabel_12.Text = '* ABD SPMM Plus';

            % Create TwistBeamLabel_4
            app.TwistBeamLabel_4 = uilabel(app.Tab_KcRear_Braking);
            app.TwistBeamLabel_4.FontName = 'Times New Roman';
            app.TwistBeamLabel_4.FontSize = 10;
            app.TwistBeamLabel_4.FontAngle = 'italic';
            app.TwistBeamLabel_4.Position = [1069 186 108 22];
            app.TwistBeamLabel_4.Text = '   TwistBeam';

            % Create VWGolfButton_5
            app.VWGolfButton_5 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.VWGolfButton_5.Text = 'VW Golf';
            app.VWGolfButton_5.Position = [1075 131 89 23];

            % Create VWUPButton_4
            app.VWUPButton_4 = uibutton(app.Tab_KcRear_Braking, 'state');
            app.VWUPButton_4.Text = 'VW UP!';
            app.VWUPButton_4.Position = [1075 105 89 23];

            % Create Button_7
            app.Button_7 = uibutton(app.Tab_KcRear_Braking, 'push');
            app.Button_7.ButtonPushedFcn = createCallbackFcn(app, @Button_7Pushed, true);
            app.Button_7.Icon = fullfile(pathToMLAPP, 'Icon_plot_custerm.png');
            app.Button_7.Position = [1075 11 40 41];
            app.Button_7.Text = '';

            % Create Button_8
            app.Button_8 = uibutton(app.Tab_KcRear_Braking, 'push');
            app.Button_8.Icon = fullfile(pathToMLAPP, 'icon_to_ppt.png');
            app.Button_8.Position = [1127 12 37 40];
            app.Button_8.Text = '';

            % Create Tab_KcRear_Accel
            app.Tab_KcRear_Accel = uitab(app.Tab_KcRear);
            app.Tab_KcRear_Accel.Title = 'Driving Force @WC';

            % Create EditField_R_accel_rangeshow
            app.EditField_R_accel_rangeshow = uieditfield(app.Tab_KcRear_Accel, 'numeric');
            app.EditField_R_accel_rangeshow.FontName = 'Times New Roman';
            app.EditField_R_accel_rangeshow.FontSize = 10;
            app.EditField_R_accel_rangeshow.Position = [871 491 46 18];
            app.EditField_R_accel_rangeshow.Value = 500;

            % Create mmLabel_R_accel_rangshow
            app.mmLabel_R_accel_rangshow = uilabel(app.Tab_KcRear_Accel);
            app.mmLabel_R_accel_rangshow.FontName = 'Times New Roman';
            app.mmLabel_R_accel_rangshow.Position = [918 489 43 22];
            app.mmLabel_R_accel_rangshow.Text = '* +/-1N';

            % Create TabGroup_R_accel_results
            app.TabGroup_R_accel_results = uitabgroup(app.Tab_KcRear_Accel);
            app.TabGroup_R_accel_results.Position = [304 10 756 468];

            % Create accelSteerTab
            app.accelSteerTab = uitab(app.TabGroup_R_accel_results);
            app.accelSteerTab.Title = 'Drive Steer';
            app.accelSteerTab.BackgroundColor = [1 1 1];

            % Create GridLayout_33
            app.GridLayout_33 = uigridlayout(app.accelSteerTab);
            app.GridLayout_33.ColumnWidth = {'5x', '5x'};
            app.GridLayout_33.RowHeight = {'24x', '8x'};
            app.GridLayout_33.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_acceltoe
            app.UIAxesRight_R_acceltoe = uiaxes(app.GridLayout_33);
            title(app.UIAxesRight_R_acceltoe, 'Title')
            xlabel(app.UIAxesRight_R_acceltoe, 'X')
            ylabel(app.UIAxesRight_R_acceltoe, 'Y')
            zlabel(app.UIAxesRight_R_acceltoe, 'Z')
            app.UIAxesRight_R_acceltoe.FontName = 'Times New Roman';
            app.UIAxesRight_R_acceltoe.XLim = [-4000 4000];
            app.UIAxesRight_R_acceltoe.FontSize = 8;
            app.UIAxesRight_R_acceltoe.Layout.Row = 1;
            app.UIAxesRight_R_acceltoe.Layout.Column = 2;

            % Create UIAxesLeft_R_acceltoe
            app.UIAxesLeft_R_acceltoe = uiaxes(app.GridLayout_33);
            title(app.UIAxesLeft_R_acceltoe, 'Title')
            xlabel(app.UIAxesLeft_R_acceltoe, 'X')
            ylabel(app.UIAxesLeft_R_acceltoe, 'Y')
            zlabel(app.UIAxesLeft_R_acceltoe, 'Z')
            app.UIAxesLeft_R_acceltoe.FontName = 'Times New Roman';
            app.UIAxesLeft_R_acceltoe.XLim = [-4000 4000];
            app.UIAxesLeft_R_acceltoe.GridLineWidth = 0.1;
            app.UIAxesLeft_R_acceltoe.MinorGridLineWidth = 0.1;
            app.UIAxesLeft_R_acceltoe.GridAlpha = 0.1;
            app.UIAxesLeft_R_acceltoe.FontSize = 8;
            app.UIAxesLeft_R_acceltoe.Layout.Row = 1;
            app.UIAxesLeft_R_acceltoe.Layout.Column = 1;

            % Create InfoPanel_33
            app.InfoPanel_33 = uipanel(app.GridLayout_33);
            app.InfoPanel_33.BorderType = 'none';
            app.InfoPanel_33.Title = 'Info.';
            app.InfoPanel_33.BackgroundColor = [1 1 1];
            app.InfoPanel_33.Layout.Row = 2;
            app.InfoPanel_33.Layout.Column = 2;
            app.InfoPanel_33.FontWeight = 'bold';

            % Create DatePicker_33
            app.DatePicker_33 = uidatepicker(app.InfoPanel_33);
            app.DatePicker_33.Position = [175 7 112 18];
            app.DatePicker_33.Value = datetime([2025 1 1]);

            % Create VersionEditField_33Label
            app.VersionEditField_33Label = uilabel(app.InfoPanel_33);
            app.VersionEditField_33Label.BackgroundColor = [1 1 1];
            app.VersionEditField_33Label.HorizontalAlignment = 'right';
            app.VersionEditField_33Label.Position = [4 32 48 22];
            app.VersionEditField_33Label.Text = 'Version:';

            % Create VersionEditField_33
            app.VersionEditField_33 = uieditfield(app.InfoPanel_33, 'text');
            app.VersionEditField_33.HorizontalAlignment = 'center';
            app.VersionEditField_33.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_33.Position = [63 34 77 17];
            app.VersionEditField_33.Value = 'G046';

            % Create FlexbodySwitch_33
            app.FlexbodySwitch_33 = uiswitch(app.InfoPanel_33, 'slider');
            app.FlexbodySwitch_33.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_33.FontSize = 9;
            app.FlexbodySwitch_33.Position = [219 34 35 16];
            app.FlexbodySwitch_33.Value = 'Flex-Off';

            % Create CreatorDropDown_33Label
            app.CreatorDropDown_33Label = uilabel(app.InfoPanel_33);
            app.CreatorDropDown_33Label.FontSize = 8;
            app.CreatorDropDown_33Label.Position = [8 5 50 22];
            app.CreatorDropDown_33Label.Text = 'Creator:';

            % Create CreatorDropDown_33
            app.CreatorDropDown_33 = uidropdown(app.InfoPanel_33);
            app.CreatorDropDown_33.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_33.FontSize = 8;
            app.CreatorDropDown_33.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_33.Position = [63 7 100 16];
            app.CreatorDropDown_33.Value = 'Q. Rong';

            % Create Image2_40
            app.Image2_40 = uiimage(app.InfoPanel_33);
            app.Image2_40.Position = [297 8 26 25];
            app.Image2_40.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_33
            app.Image9_33 = uiimage(app.InfoPanel_33);
            app.Image9_33.Position = [328 4 30 28];
            app.Image9_33.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create AccelerationForceTestLabel_8
            app.AccelerationForceTestLabel_8 = uilabel(app.InfoPanel_33);
            app.AccelerationForceTestLabel_8.BackgroundColor = [0.4941 0.1843 0.5569];
            app.AccelerationForceTestLabel_8.HorizontalAlignment = 'right';
            app.AccelerationForceTestLabel_8.FontWeight = 'bold';
            app.AccelerationForceTestLabel_8.FontColor = [1 1 1];
            app.AccelerationForceTestLabel_8.Position = [218 55 140 22];
            app.AccelerationForceTestLabel_8.Text = 'Acceleration Force Test';

            % Create ProjectEditField_34Label
            app.ProjectEditField_34Label = uilabel(app.InfoPanel_33);
            app.ProjectEditField_34Label.HorizontalAlignment = 'right';
            app.ProjectEditField_34Label.Position = [4 57 46 22];
            app.ProjectEditField_34Label.Text = 'Project:';

            % Create ProjectEditField_34
            app.ProjectEditField_34 = uieditfield(app.InfoPanel_33, 'text');
            app.ProjectEditField_34.Position = [63 59 137 18];
            app.ProjectEditField_34.Value = 'Gestamp NRAC';

            % Create ResultEvaluationPanel_33
            app.ResultEvaluationPanel_33 = uipanel(app.GridLayout_33);
            app.ResultEvaluationPanel_33.BorderType = 'none';
            app.ResultEvaluationPanel_33.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_33.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_33.Layout.Row = 2;
            app.ResultEvaluationPanel_33.Layout.Column = 1;
            app.ResultEvaluationPanel_33.FontWeight = 'bold';

            % Create BewertungDropDown_33
            app.BewertungDropDown_33 = uidropdown(app.ResultEvaluationPanel_33);
            app.BewertungDropDown_33.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_33.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_33ValueChanged, true);
            app.BewertungDropDown_33.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_33.Position = [5 57 326 22];
            app.BewertungDropDown_33.Value = 'The current results meet the requirements';

            % Create Lamp_33
            app.Lamp_33 = uilamp(app.ResultEvaluationPanel_33);
            app.Lamp_33.Position = [336 58 20 20];
            app.Lamp_33.Color = [1 1 0.0667];

            % Create TextArea_34
            app.TextArea_34 = uitextarea(app.ResultEvaluationPanel_33);
            app.TextArea_34.Position = [5 3 352 50];

            % Create accelCamberTab
            app.accelCamberTab = uitab(app.TabGroup_R_accel_results);
            app.accelCamberTab.Title = 'Drive Camber';
            app.accelCamberTab.BackgroundColor = [1 1 1];

            % Create GridLayout_34
            app.GridLayout_34 = uigridlayout(app.accelCamberTab);
            app.GridLayout_34.ColumnWidth = {'5x', '5x'};
            app.GridLayout_34.RowHeight = {'24x', '8x'};
            app.GridLayout_34.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_accelcamber
            app.UIAxesRight_R_accelcamber = uiaxes(app.GridLayout_34);
            title(app.UIAxesRight_R_accelcamber, 'Title')
            xlabel(app.UIAxesRight_R_accelcamber, 'X')
            ylabel(app.UIAxesRight_R_accelcamber, 'Y')
            zlabel(app.UIAxesRight_R_accelcamber, 'Z')
            app.UIAxesRight_R_accelcamber.FontName = 'Times New Roman';
            app.UIAxesRight_R_accelcamber.XLim = [-4000 4000];
            app.UIAxesRight_R_accelcamber.FontSize = 8;
            app.UIAxesRight_R_accelcamber.Layout.Row = 1;
            app.UIAxesRight_R_accelcamber.Layout.Column = 2;

            % Create UIAxesLeft_R_accelcamber
            app.UIAxesLeft_R_accelcamber = uiaxes(app.GridLayout_34);
            title(app.UIAxesLeft_R_accelcamber, 'Title')
            xlabel(app.UIAxesLeft_R_accelcamber, 'X')
            ylabel(app.UIAxesLeft_R_accelcamber, 'Y')
            zlabel(app.UIAxesLeft_R_accelcamber, 'Z')
            app.UIAxesLeft_R_accelcamber.FontName = 'Times New Roman';
            app.UIAxesLeft_R_accelcamber.XLim = [-4000 4000];
            app.UIAxesLeft_R_accelcamber.FontSize = 8;
            app.UIAxesLeft_R_accelcamber.Layout.Row = 1;
            app.UIAxesLeft_R_accelcamber.Layout.Column = 1;

            % Create ResultEvaluationPanel_34
            app.ResultEvaluationPanel_34 = uipanel(app.GridLayout_34);
            app.ResultEvaluationPanel_34.BorderType = 'none';
            app.ResultEvaluationPanel_34.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_34.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_34.Layout.Row = 2;
            app.ResultEvaluationPanel_34.Layout.Column = 1;
            app.ResultEvaluationPanel_34.FontWeight = 'bold';

            % Create BewertungDropDown_34
            app.BewertungDropDown_34 = uidropdown(app.ResultEvaluationPanel_34);
            app.BewertungDropDown_34.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_34.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_34ValueChanged, true);
            app.BewertungDropDown_34.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_34.Position = [5 57 326 22];
            app.BewertungDropDown_34.Value = 'The current results meet the requirements';

            % Create Lamp_34
            app.Lamp_34 = uilamp(app.ResultEvaluationPanel_34);
            app.Lamp_34.Position = [336 58 20 20];
            app.Lamp_34.Color = [1 1 0.0667];

            % Create TextArea_35
            app.TextArea_35 = uitextarea(app.ResultEvaluationPanel_34);
            app.TextArea_35.Position = [5 3 352 50];

            % Create InfoPanel_34
            app.InfoPanel_34 = uipanel(app.GridLayout_34);
            app.InfoPanel_34.BorderType = 'none';
            app.InfoPanel_34.Title = 'Info.';
            app.InfoPanel_34.BackgroundColor = [1 1 1];
            app.InfoPanel_34.Layout.Row = 2;
            app.InfoPanel_34.Layout.Column = 2;
            app.InfoPanel_34.FontWeight = 'bold';

            % Create DatePicker_34
            app.DatePicker_34 = uidatepicker(app.InfoPanel_34);
            app.DatePicker_34.Position = [175 7 112 18];
            app.DatePicker_34.Value = datetime([2025 1 1]);

            % Create ProjectEditField_35Label
            app.ProjectEditField_35Label = uilabel(app.InfoPanel_34);
            app.ProjectEditField_35Label.HorizontalAlignment = 'right';
            app.ProjectEditField_35Label.Position = [4 57 46 22];
            app.ProjectEditField_35Label.Text = 'Project:';

            % Create ProjectEditField_35
            app.ProjectEditField_35 = uieditfield(app.InfoPanel_34, 'text');
            app.ProjectEditField_35.Position = [63 59 137 18];
            app.ProjectEditField_35.Value = 'Gestamp NRAC';

            % Create VersionEditField_34Label
            app.VersionEditField_34Label = uilabel(app.InfoPanel_34);
            app.VersionEditField_34Label.BackgroundColor = [1 1 1];
            app.VersionEditField_34Label.HorizontalAlignment = 'right';
            app.VersionEditField_34Label.Position = [4 31 48 22];
            app.VersionEditField_34Label.Text = 'Version:';

            % Create VersionEditField_34
            app.VersionEditField_34 = uieditfield(app.InfoPanel_34, 'text');
            app.VersionEditField_34.HorizontalAlignment = 'center';
            app.VersionEditField_34.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_34.Position = [63 34 77 17];
            app.VersionEditField_34.Value = 'G046';

            % Create FlexbodySwitch_34
            app.FlexbodySwitch_34 = uiswitch(app.InfoPanel_34, 'slider');
            app.FlexbodySwitch_34.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_34.FontSize = 9;
            app.FlexbodySwitch_34.Position = [219 34 35 16];
            app.FlexbodySwitch_34.Value = 'Flex-Off';

            % Create CreatorDropDown_34Label
            app.CreatorDropDown_34Label = uilabel(app.InfoPanel_34);
            app.CreatorDropDown_34Label.FontSize = 8;
            app.CreatorDropDown_34Label.Position = [8 4 50 22];
            app.CreatorDropDown_34Label.Text = 'Creator:';

            % Create CreatorDropDown_34
            app.CreatorDropDown_34 = uidropdown(app.InfoPanel_34);
            app.CreatorDropDown_34.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_34.FontSize = 8;
            app.CreatorDropDown_34.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_34.Position = [63 7 100 16];
            app.CreatorDropDown_34.Value = 'Q. Rong';

            % Create Image2_41
            app.Image2_41 = uiimage(app.InfoPanel_34);
            app.Image2_41.Position = [297 8 26 25];
            app.Image2_41.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_34
            app.Image9_34 = uiimage(app.InfoPanel_34);
            app.Image9_34.Position = [328 4 30 28];
            app.Image9_34.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create AccelerationForceTestLabel_7
            app.AccelerationForceTestLabel_7 = uilabel(app.InfoPanel_34);
            app.AccelerationForceTestLabel_7.BackgroundColor = [0.4941 0.1843 0.5569];
            app.AccelerationForceTestLabel_7.HorizontalAlignment = 'right';
            app.AccelerationForceTestLabel_7.FontWeight = 'bold';
            app.AccelerationForceTestLabel_7.FontColor = [1 1 1];
            app.AccelerationForceTestLabel_7.Position = [218 55 140 22];
            app.AccelerationForceTestLabel_7.Text = 'Acceleration Force Test';

            % Create accelComplianceWCTab
            app.accelComplianceWCTab = uitab(app.TabGroup_R_accel_results);
            app.accelComplianceWCTab.Title = 'Drive Wheel Recession @WC';
            app.accelComplianceWCTab.BackgroundColor = [1 1 1];

            % Create GridLayout_35
            app.GridLayout_35 = uigridlayout(app.accelComplianceWCTab);
            app.GridLayout_35.ColumnWidth = {'5x', '5x'};
            app.GridLayout_35.RowHeight = {'24x', '8x'};
            app.GridLayout_35.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_accelcomp
            app.UIAxesRight_R_accelcomp = uiaxes(app.GridLayout_35);
            title(app.UIAxesRight_R_accelcomp, 'Title')
            xlabel(app.UIAxesRight_R_accelcomp, 'X')
            ylabel(app.UIAxesRight_R_accelcomp, 'Y')
            zlabel(app.UIAxesRight_R_accelcomp, 'Z')
            app.UIAxesRight_R_accelcomp.FontName = 'Times New Roman';
            app.UIAxesRight_R_accelcomp.XLim = [-4000 4000];
            app.UIAxesRight_R_accelcomp.FontSize = 8;
            app.UIAxesRight_R_accelcomp.Layout.Row = 1;
            app.UIAxesRight_R_accelcomp.Layout.Column = 2;

            % Create UIAxesLeft_R_accelcomp
            app.UIAxesLeft_R_accelcomp = uiaxes(app.GridLayout_35);
            title(app.UIAxesLeft_R_accelcomp, 'Title')
            xlabel(app.UIAxesLeft_R_accelcomp, 'X')
            ylabel(app.UIAxesLeft_R_accelcomp, 'Y')
            zlabel(app.UIAxesLeft_R_accelcomp, 'Z')
            app.UIAxesLeft_R_accelcomp.FontName = 'Times New Roman';
            app.UIAxesLeft_R_accelcomp.XLim = [-4000 4000];
            app.UIAxesLeft_R_accelcomp.FontSize = 8;
            app.UIAxesLeft_R_accelcomp.Layout.Row = 1;
            app.UIAxesLeft_R_accelcomp.Layout.Column = 1;

            % Create ResultEvaluationPanel_35
            app.ResultEvaluationPanel_35 = uipanel(app.GridLayout_35);
            app.ResultEvaluationPanel_35.BorderType = 'none';
            app.ResultEvaluationPanel_35.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_35.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_35.Layout.Row = 2;
            app.ResultEvaluationPanel_35.Layout.Column = 1;
            app.ResultEvaluationPanel_35.FontWeight = 'bold';

            % Create BewertungDropDown_35
            app.BewertungDropDown_35 = uidropdown(app.ResultEvaluationPanel_35);
            app.BewertungDropDown_35.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_35.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_35ValueChanged, true);
            app.BewertungDropDown_35.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_35.Position = [5 57 326 22];
            app.BewertungDropDown_35.Value = 'The current results meet the requirements';

            % Create Lamp_35
            app.Lamp_35 = uilamp(app.ResultEvaluationPanel_35);
            app.Lamp_35.Position = [336 58 20 20];
            app.Lamp_35.Color = [1 1 0.0667];

            % Create TextArea_36
            app.TextArea_36 = uitextarea(app.ResultEvaluationPanel_35);
            app.TextArea_36.Position = [5 3 352 50];

            % Create InfoPanel_35
            app.InfoPanel_35 = uipanel(app.GridLayout_35);
            app.InfoPanel_35.BorderType = 'none';
            app.InfoPanel_35.Title = 'Info.';
            app.InfoPanel_35.BackgroundColor = [1 1 1];
            app.InfoPanel_35.Layout.Row = 2;
            app.InfoPanel_35.Layout.Column = 2;
            app.InfoPanel_35.FontWeight = 'bold';

            % Create DatePicker_35
            app.DatePicker_35 = uidatepicker(app.InfoPanel_35);
            app.DatePicker_35.Position = [175 7 112 18];
            app.DatePicker_35.Value = datetime([2025 1 1]);

            % Create ProjectEditField_36Label
            app.ProjectEditField_36Label = uilabel(app.InfoPanel_35);
            app.ProjectEditField_36Label.HorizontalAlignment = 'right';
            app.ProjectEditField_36Label.Position = [4 57 46 22];
            app.ProjectEditField_36Label.Text = 'Project:';

            % Create ProjectEditField_36
            app.ProjectEditField_36 = uieditfield(app.InfoPanel_35, 'text');
            app.ProjectEditField_36.Position = [63 59 137 18];
            app.ProjectEditField_36.Value = 'Gestamp NRAC';

            % Create VersionEditField_35Label
            app.VersionEditField_35Label = uilabel(app.InfoPanel_35);
            app.VersionEditField_35Label.BackgroundColor = [1 1 1];
            app.VersionEditField_35Label.HorizontalAlignment = 'right';
            app.VersionEditField_35Label.Position = [4 31 48 22];
            app.VersionEditField_35Label.Text = 'Version:';

            % Create VersionEditField_35
            app.VersionEditField_35 = uieditfield(app.InfoPanel_35, 'text');
            app.VersionEditField_35.HorizontalAlignment = 'center';
            app.VersionEditField_35.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_35.Position = [63 34 77 17];
            app.VersionEditField_35.Value = 'G046';

            % Create FlexbodySwitch_35
            app.FlexbodySwitch_35 = uiswitch(app.InfoPanel_35, 'slider');
            app.FlexbodySwitch_35.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_35.FontSize = 9;
            app.FlexbodySwitch_35.Position = [219 34 35 16];
            app.FlexbodySwitch_35.Value = 'Flex-Off';

            % Create CreatorDropDown_35Label
            app.CreatorDropDown_35Label = uilabel(app.InfoPanel_35);
            app.CreatorDropDown_35Label.FontSize = 8;
            app.CreatorDropDown_35Label.Position = [8 4 50 22];
            app.CreatorDropDown_35Label.Text = 'Creator:';

            % Create CreatorDropDown_35
            app.CreatorDropDown_35 = uidropdown(app.InfoPanel_35);
            app.CreatorDropDown_35.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_35.FontSize = 8;
            app.CreatorDropDown_35.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_35.Position = [63 7 100 16];
            app.CreatorDropDown_35.Value = 'Q. Rong';

            % Create Image2_42
            app.Image2_42 = uiimage(app.InfoPanel_35);
            app.Image2_42.Position = [297 8 26 25];
            app.Image2_42.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_35
            app.Image9_35 = uiimage(app.InfoPanel_35);
            app.Image9_35.Position = [328 4 30 28];
            app.Image9_35.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create AccelerationForceTestLabel_6
            app.AccelerationForceTestLabel_6 = uilabel(app.InfoPanel_35);
            app.AccelerationForceTestLabel_6.BackgroundColor = [0.4941 0.1843 0.5569];
            app.AccelerationForceTestLabel_6.HorizontalAlignment = 'right';
            app.AccelerationForceTestLabel_6.FontWeight = 'bold';
            app.AccelerationForceTestLabel_6.FontColor = [1 1 1];
            app.AccelerationForceTestLabel_6.Position = [218 55 140 22];
            app.AccelerationForceTestLabel_6.Text = 'Acceleration Force Test';

            % Create antiSquatTab
            app.antiSquatTab = uitab(app.TabGroup_R_accel_results);
            app.antiSquatTab.Title = 'anti-Squat';

            % Create GridLayout_36
            app.GridLayout_36 = uigridlayout(app.antiSquatTab);
            app.GridLayout_36.ColumnWidth = {'5x', '5x'};
            app.GridLayout_36.RowHeight = {'24x', '8x'};
            app.GridLayout_36.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_accelantidive
            app.UIAxesRight_R_accelantidive = uiaxes(app.GridLayout_36);
            title(app.UIAxesRight_R_accelantidive, 'Title')
            xlabel(app.UIAxesRight_R_accelantidive, 'X')
            ylabel(app.UIAxesRight_R_accelantidive, 'Y')
            zlabel(app.UIAxesRight_R_accelantidive, 'Z')
            app.UIAxesRight_R_accelantidive.FontName = 'Times New Roman';
            app.UIAxesRight_R_accelantidive.XLim = [-4000 4000];
            app.UIAxesRight_R_accelantidive.FontSize = 8;
            app.UIAxesRight_R_accelantidive.Layout.Row = 1;
            app.UIAxesRight_R_accelantidive.Layout.Column = 2;

            % Create UIAxesLeft_R_accelantidive
            app.UIAxesLeft_R_accelantidive = uiaxes(app.GridLayout_36);
            title(app.UIAxesLeft_R_accelantidive, 'Title')
            xlabel(app.UIAxesLeft_R_accelantidive, 'X')
            ylabel(app.UIAxesLeft_R_accelantidive, 'Y')
            zlabel(app.UIAxesLeft_R_accelantidive, 'Z')
            app.UIAxesLeft_R_accelantidive.FontName = 'Times New Roman';
            app.UIAxesLeft_R_accelantidive.XLim = [-4000 4000];
            app.UIAxesLeft_R_accelantidive.FontSize = 8;
            app.UIAxesLeft_R_accelantidive.Layout.Row = 1;
            app.UIAxesLeft_R_accelantidive.Layout.Column = 1;

            % Create ResultEvaluationPanel_36
            app.ResultEvaluationPanel_36 = uipanel(app.GridLayout_36);
            app.ResultEvaluationPanel_36.BorderType = 'none';
            app.ResultEvaluationPanel_36.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_36.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_36.Layout.Row = 2;
            app.ResultEvaluationPanel_36.Layout.Column = 1;
            app.ResultEvaluationPanel_36.FontWeight = 'bold';

            % Create BewertungDropDown_36
            app.BewertungDropDown_36 = uidropdown(app.ResultEvaluationPanel_36);
            app.BewertungDropDown_36.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_36.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_36ValueChanged, true);
            app.BewertungDropDown_36.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_36.Position = [5 57 326 22];
            app.BewertungDropDown_36.Value = 'The current results meet the requirements';

            % Create Lamp_36
            app.Lamp_36 = uilamp(app.ResultEvaluationPanel_36);
            app.Lamp_36.Position = [336 58 20 20];
            app.Lamp_36.Color = [1 1 0.0667];

            % Create TextArea_37
            app.TextArea_37 = uitextarea(app.ResultEvaluationPanel_36);
            app.TextArea_37.Position = [5 3 352 50];

            % Create InfoPanel_36
            app.InfoPanel_36 = uipanel(app.GridLayout_36);
            app.InfoPanel_36.BorderType = 'none';
            app.InfoPanel_36.Title = 'Info.';
            app.InfoPanel_36.BackgroundColor = [1 1 1];
            app.InfoPanel_36.Layout.Row = 2;
            app.InfoPanel_36.Layout.Column = 2;
            app.InfoPanel_36.FontWeight = 'bold';

            % Create DatePicker_36
            app.DatePicker_36 = uidatepicker(app.InfoPanel_36);
            app.DatePicker_36.Position = [175 7 112 18];
            app.DatePicker_36.Value = datetime([2025 1 1]);

            % Create ProjectEditField_37Label
            app.ProjectEditField_37Label = uilabel(app.InfoPanel_36);
            app.ProjectEditField_37Label.HorizontalAlignment = 'right';
            app.ProjectEditField_37Label.Position = [4 57 46 22];
            app.ProjectEditField_37Label.Text = 'Project:';

            % Create ProjectEditField_37
            app.ProjectEditField_37 = uieditfield(app.InfoPanel_36, 'text');
            app.ProjectEditField_37.Position = [63 59 137 18];
            app.ProjectEditField_37.Value = 'Gestamp NRAC';

            % Create VersionEditField_36Label
            app.VersionEditField_36Label = uilabel(app.InfoPanel_36);
            app.VersionEditField_36Label.BackgroundColor = [1 1 1];
            app.VersionEditField_36Label.HorizontalAlignment = 'right';
            app.VersionEditField_36Label.Position = [4 31 48 22];
            app.VersionEditField_36Label.Text = 'Version:';

            % Create VersionEditField_36
            app.VersionEditField_36 = uieditfield(app.InfoPanel_36, 'text');
            app.VersionEditField_36.HorizontalAlignment = 'center';
            app.VersionEditField_36.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_36.Position = [63 34 77 17];
            app.VersionEditField_36.Value = 'G046';

            % Create FlexbodySwitch_36
            app.FlexbodySwitch_36 = uiswitch(app.InfoPanel_36, 'slider');
            app.FlexbodySwitch_36.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_36.FontSize = 9;
            app.FlexbodySwitch_36.Position = [219 34 35 16];
            app.FlexbodySwitch_36.Value = 'Flex-Off';

            % Create Image2_43
            app.Image2_43 = uiimage(app.InfoPanel_36);
            app.Image2_43.Position = [297 8 26 25];
            app.Image2_43.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_36Label
            app.CreatorDropDown_36Label = uilabel(app.InfoPanel_36);
            app.CreatorDropDown_36Label.FontSize = 8;
            app.CreatorDropDown_36Label.Position = [8 4 50 22];
            app.CreatorDropDown_36Label.Text = 'Creator:';

            % Create CreatorDropDown_36
            app.CreatorDropDown_36 = uidropdown(app.InfoPanel_36);
            app.CreatorDropDown_36.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_36.FontSize = 8;
            app.CreatorDropDown_36.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_36.Position = [63 7 100 16];
            app.CreatorDropDown_36.Value = 'Q. Rong';

            % Create Image9_36
            app.Image9_36 = uiimage(app.InfoPanel_36);
            app.Image9_36.Position = [328 4 30 28];
            app.Image9_36.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create AccelerationForceTestLabel_5
            app.AccelerationForceTestLabel_5 = uilabel(app.InfoPanel_36);
            app.AccelerationForceTestLabel_5.BackgroundColor = [0.4941 0.1843 0.5569];
            app.AccelerationForceTestLabel_5.HorizontalAlignment = 'right';
            app.AccelerationForceTestLabel_5.FontWeight = 'bold';
            app.AccelerationForceTestLabel_5.FontColor = [1 1 1];
            app.AccelerationForceTestLabel_5.Position = [218 55 140 22];
            app.AccelerationForceTestLabel_5.Text = 'Acceleration Force Test';

            % Create accelSpinTab
            app.accelSpinTab = uitab(app.TabGroup_R_accel_results);
            app.accelSpinTab.Title = 'Drive Spin';
            app.accelSpinTab.BackgroundColor = [1 1 1];

            % Create GridLayout_37
            app.GridLayout_37 = uigridlayout(app.accelSpinTab);
            app.GridLayout_37.ColumnWidth = {'5x', '5x'};
            app.GridLayout_37.RowHeight = {'24x', '8x'};
            app.GridLayout_37.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_accelspin
            app.UIAxesRight_R_accelspin = uiaxes(app.GridLayout_37);
            title(app.UIAxesRight_R_accelspin, 'Title')
            xlabel(app.UIAxesRight_R_accelspin, 'X')
            ylabel(app.UIAxesRight_R_accelspin, 'Y')
            zlabel(app.UIAxesRight_R_accelspin, 'Z')
            app.UIAxesRight_R_accelspin.FontName = 'Times New Roman';
            app.UIAxesRight_R_accelspin.XLim = [-4000 4000];
            app.UIAxesRight_R_accelspin.FontSize = 8;
            app.UIAxesRight_R_accelspin.Layout.Row = 1;
            app.UIAxesRight_R_accelspin.Layout.Column = 2;

            % Create UIAxesLeft_R_accelspin
            app.UIAxesLeft_R_accelspin = uiaxes(app.GridLayout_37);
            title(app.UIAxesLeft_R_accelspin, 'Title')
            xlabel(app.UIAxesLeft_R_accelspin, 'X')
            ylabel(app.UIAxesLeft_R_accelspin, 'Y')
            zlabel(app.UIAxesLeft_R_accelspin, 'Z')
            app.UIAxesLeft_R_accelspin.FontName = 'Times New Roman';
            app.UIAxesLeft_R_accelspin.XLim = [-4000 4000];
            app.UIAxesLeft_R_accelspin.FontSize = 8;
            app.UIAxesLeft_R_accelspin.Layout.Row = 1;
            app.UIAxesLeft_R_accelspin.Layout.Column = 1;

            % Create ResultEvaluationPanel_37
            app.ResultEvaluationPanel_37 = uipanel(app.GridLayout_37);
            app.ResultEvaluationPanel_37.BorderType = 'none';
            app.ResultEvaluationPanel_37.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_37.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_37.Layout.Row = 2;
            app.ResultEvaluationPanel_37.Layout.Column = 1;
            app.ResultEvaluationPanel_37.FontWeight = 'bold';

            % Create BewertungDropDown_37
            app.BewertungDropDown_37 = uidropdown(app.ResultEvaluationPanel_37);
            app.BewertungDropDown_37.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_37.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_37ValueChanged, true);
            app.BewertungDropDown_37.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_37.Position = [5 57 326 22];
            app.BewertungDropDown_37.Value = 'The current results meet the requirements';

            % Create Lamp_37
            app.Lamp_37 = uilamp(app.ResultEvaluationPanel_37);
            app.Lamp_37.Position = [336 58 20 20];
            app.Lamp_37.Color = [1 1 0.0667];

            % Create TextArea_38
            app.TextArea_38 = uitextarea(app.ResultEvaluationPanel_37);
            app.TextArea_38.Position = [5 3 352 50];

            % Create InfoPanel_37
            app.InfoPanel_37 = uipanel(app.GridLayout_37);
            app.InfoPanel_37.BorderType = 'none';
            app.InfoPanel_37.Title = 'Info.';
            app.InfoPanel_37.BackgroundColor = [1 1 1];
            app.InfoPanel_37.Layout.Row = 2;
            app.InfoPanel_37.Layout.Column = 2;
            app.InfoPanel_37.FontWeight = 'bold';

            % Create DatePicker_37
            app.DatePicker_37 = uidatepicker(app.InfoPanel_37);
            app.DatePicker_37.Position = [175 7 112 18];
            app.DatePicker_37.Value = datetime([2025 1 1]);

            % Create ProjectEditField_38Label
            app.ProjectEditField_38Label = uilabel(app.InfoPanel_37);
            app.ProjectEditField_38Label.HorizontalAlignment = 'right';
            app.ProjectEditField_38Label.Position = [4 57 46 22];
            app.ProjectEditField_38Label.Text = 'Project:';

            % Create ProjectEditField_38
            app.ProjectEditField_38 = uieditfield(app.InfoPanel_37, 'text');
            app.ProjectEditField_38.Position = [63 59 137 18];
            app.ProjectEditField_38.Value = 'Gestamp NRAC';

            % Create VersionEditField_37Label
            app.VersionEditField_37Label = uilabel(app.InfoPanel_37);
            app.VersionEditField_37Label.BackgroundColor = [1 1 1];
            app.VersionEditField_37Label.HorizontalAlignment = 'right';
            app.VersionEditField_37Label.Position = [4 31 48 22];
            app.VersionEditField_37Label.Text = 'Version:';

            % Create VersionEditField_37
            app.VersionEditField_37 = uieditfield(app.InfoPanel_37, 'text');
            app.VersionEditField_37.HorizontalAlignment = 'center';
            app.VersionEditField_37.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_37.Position = [63 34 77 17];
            app.VersionEditField_37.Value = 'G046';

            % Create FlexbodySwitch_37
            app.FlexbodySwitch_37 = uiswitch(app.InfoPanel_37, 'slider');
            app.FlexbodySwitch_37.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_37.FontSize = 9;
            app.FlexbodySwitch_37.Position = [219 34 35 16];
            app.FlexbodySwitch_37.Value = 'Flex-Off';

            % Create CreatorDropDown_37Label
            app.CreatorDropDown_37Label = uilabel(app.InfoPanel_37);
            app.CreatorDropDown_37Label.FontSize = 8;
            app.CreatorDropDown_37Label.Position = [8 4 50 22];
            app.CreatorDropDown_37Label.Text = 'Creator:';

            % Create CreatorDropDown_37
            app.CreatorDropDown_37 = uidropdown(app.InfoPanel_37);
            app.CreatorDropDown_37.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_37.FontSize = 8;
            app.CreatorDropDown_37.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_37.Position = [63 7 100 16];
            app.CreatorDropDown_37.Value = 'Q. Rong';

            % Create Image2_44
            app.Image2_44 = uiimage(app.InfoPanel_37);
            app.Image2_44.Position = [297 8 26 25];
            app.Image2_44.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_37
            app.Image9_37 = uiimage(app.InfoPanel_37);
            app.Image9_37.Position = [328 4 30 28];
            app.Image9_37.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create AccelerationForceTestLabel_4
            app.AccelerationForceTestLabel_4 = uilabel(app.InfoPanel_37);
            app.AccelerationForceTestLabel_4.BackgroundColor = [0.4941 0.1843 0.5569];
            app.AccelerationForceTestLabel_4.HorizontalAlignment = 'right';
            app.AccelerationForceTestLabel_4.FontWeight = 'bold';
            app.AccelerationForceTestLabel_4.FontColor = [1 1 1];
            app.AccelerationForceTestLabel_4.Position = [218 55 140 22];
            app.AccelerationForceTestLabel_4.Text = 'Acceleration Force Test';

            % Create accelInclinationTab
            app.accelInclinationTab = uitab(app.TabGroup_R_accel_results);
            app.accelInclinationTab.Title = 'kin. Inclination';
            app.accelInclinationTab.BackgroundColor = [1 1 1];

            % Create GridLayout_38
            app.GridLayout_38 = uigridlayout(app.accelInclinationTab);
            app.GridLayout_38.ColumnWidth = {'5x', '5x'};
            app.GridLayout_38.RowHeight = {'24x', '8x'};
            app.GridLayout_38.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_accelinc
            app.UIAxesRight_R_accelinc = uiaxes(app.GridLayout_38);
            title(app.UIAxesRight_R_accelinc, 'Title')
            xlabel(app.UIAxesRight_R_accelinc, 'X')
            ylabel(app.UIAxesRight_R_accelinc, 'Y')
            zlabel(app.UIAxesRight_R_accelinc, 'Z')
            app.UIAxesRight_R_accelinc.FontName = 'Times New Roman';
            app.UIAxesRight_R_accelinc.XLim = [-4000 4000];
            app.UIAxesRight_R_accelinc.FontSize = 8;
            app.UIAxesRight_R_accelinc.Layout.Row = 1;
            app.UIAxesRight_R_accelinc.Layout.Column = 2;

            % Create UIAxesLeft_R_accelinc
            app.UIAxesLeft_R_accelinc = uiaxes(app.GridLayout_38);
            title(app.UIAxesLeft_R_accelinc, 'Title')
            xlabel(app.UIAxesLeft_R_accelinc, 'X')
            ylabel(app.UIAxesLeft_R_accelinc, 'Y')
            zlabel(app.UIAxesLeft_R_accelinc, 'Z')
            app.UIAxesLeft_R_accelinc.FontName = 'Times New Roman';
            app.UIAxesLeft_R_accelinc.XLim = [-4000 4000];
            app.UIAxesLeft_R_accelinc.FontSize = 8;
            app.UIAxesLeft_R_accelinc.Layout.Row = 1;
            app.UIAxesLeft_R_accelinc.Layout.Column = 1;

            % Create ResultEvaluationPanel_38
            app.ResultEvaluationPanel_38 = uipanel(app.GridLayout_38);
            app.ResultEvaluationPanel_38.BorderType = 'none';
            app.ResultEvaluationPanel_38.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_38.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_38.Layout.Row = 2;
            app.ResultEvaluationPanel_38.Layout.Column = 1;
            app.ResultEvaluationPanel_38.FontWeight = 'bold';

            % Create BewertungDropDown_38
            app.BewertungDropDown_38 = uidropdown(app.ResultEvaluationPanel_38);
            app.BewertungDropDown_38.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_38.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_38ValueChanged, true);
            app.BewertungDropDown_38.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_38.Position = [5 57 326 22];
            app.BewertungDropDown_38.Value = 'The current results meet the requirements';

            % Create Lamp_38
            app.Lamp_38 = uilamp(app.ResultEvaluationPanel_38);
            app.Lamp_38.Position = [336 58 20 20];
            app.Lamp_38.Color = [1 1 0.0667];

            % Create TextArea_39
            app.TextArea_39 = uitextarea(app.ResultEvaluationPanel_38);
            app.TextArea_39.Position = [5 3 352 50];

            % Create InfoPanel_38
            app.InfoPanel_38 = uipanel(app.GridLayout_38);
            app.InfoPanel_38.BorderType = 'none';
            app.InfoPanel_38.Title = 'Info.';
            app.InfoPanel_38.BackgroundColor = [1 1 1];
            app.InfoPanel_38.Layout.Row = 2;
            app.InfoPanel_38.Layout.Column = 2;
            app.InfoPanel_38.FontWeight = 'bold';

            % Create DatePicker_38
            app.DatePicker_38 = uidatepicker(app.InfoPanel_38);
            app.DatePicker_38.Position = [175 7 112 18];
            app.DatePicker_38.Value = datetime([2025 1 1]);

            % Create ProjectEditField_39Label
            app.ProjectEditField_39Label = uilabel(app.InfoPanel_38);
            app.ProjectEditField_39Label.HorizontalAlignment = 'right';
            app.ProjectEditField_39Label.Position = [4 57 46 22];
            app.ProjectEditField_39Label.Text = 'Project:';

            % Create ProjectEditField_39
            app.ProjectEditField_39 = uieditfield(app.InfoPanel_38, 'text');
            app.ProjectEditField_39.Position = [63 59 137 18];
            app.ProjectEditField_39.Value = 'Gestamp NRAC';

            % Create VersionEditField_38Label
            app.VersionEditField_38Label = uilabel(app.InfoPanel_38);
            app.VersionEditField_38Label.BackgroundColor = [1 1 1];
            app.VersionEditField_38Label.HorizontalAlignment = 'right';
            app.VersionEditField_38Label.Position = [4 31 48 22];
            app.VersionEditField_38Label.Text = 'Version:';

            % Create VersionEditField_38
            app.VersionEditField_38 = uieditfield(app.InfoPanel_38, 'text');
            app.VersionEditField_38.HorizontalAlignment = 'center';
            app.VersionEditField_38.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_38.Position = [63 34 77 17];
            app.VersionEditField_38.Value = 'G046';

            % Create FlexbodySwitch_38
            app.FlexbodySwitch_38 = uiswitch(app.InfoPanel_38, 'slider');
            app.FlexbodySwitch_38.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_38.FontSize = 9;
            app.FlexbodySwitch_38.Position = [219 34 35 16];
            app.FlexbodySwitch_38.Value = 'Flex-Off';

            % Create CreatorDropDown_38Label
            app.CreatorDropDown_38Label = uilabel(app.InfoPanel_38);
            app.CreatorDropDown_38Label.FontSize = 8;
            app.CreatorDropDown_38Label.Position = [8 4 50 22];
            app.CreatorDropDown_38Label.Text = 'Creator:';

            % Create CreatorDropDown_38
            app.CreatorDropDown_38 = uidropdown(app.InfoPanel_38);
            app.CreatorDropDown_38.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_38.FontSize = 8;
            app.CreatorDropDown_38.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_38.Position = [63 7 100 16];
            app.CreatorDropDown_38.Value = 'Q. Rong';

            % Create Image2_45
            app.Image2_45 = uiimage(app.InfoPanel_38);
            app.Image2_45.Position = [297 8 26 25];
            app.Image2_45.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create Image9_38
            app.Image9_38 = uiimage(app.InfoPanel_38);
            app.Image9_38.Position = [328 4 30 28];
            app.Image9_38.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create AccelerationForceTestLabel_3
            app.AccelerationForceTestLabel_3 = uilabel(app.InfoPanel_38);
            app.AccelerationForceTestLabel_3.BackgroundColor = [0.4941 0.1843 0.5569];
            app.AccelerationForceTestLabel_3.HorizontalAlignment = 'right';
            app.AccelerationForceTestLabel_3.FontWeight = 'bold';
            app.AccelerationForceTestLabel_3.FontColor = [1 1 1];
            app.AccelerationForceTestLabel_3.Position = [218 55 140 22];
            app.AccelerationForceTestLabel_3.Text = 'Acceleration Force Test';

            % Create accelScrubTab
            app.accelScrubTab = uitab(app.TabGroup_R_accel_results);
            app.accelScrubTab.Title = 'Scrub Radius';
            app.accelScrubTab.BackgroundColor = [1 1 1];

            % Create GridLayout_39
            app.GridLayout_39 = uigridlayout(app.accelScrubTab);
            app.GridLayout_39.ColumnWidth = {'5x', '5x'};
            app.GridLayout_39.RowHeight = {'24x', '8x'};
            app.GridLayout_39.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_accelsr
            app.UIAxesRight_R_accelsr = uiaxes(app.GridLayout_39);
            title(app.UIAxesRight_R_accelsr, 'Title')
            xlabel(app.UIAxesRight_R_accelsr, 'X')
            ylabel(app.UIAxesRight_R_accelsr, 'Y')
            zlabel(app.UIAxesRight_R_accelsr, 'Z')
            app.UIAxesRight_R_accelsr.FontName = 'Times New Roman';
            app.UIAxesRight_R_accelsr.XLim = [-4000 4000];
            app.UIAxesRight_R_accelsr.FontSize = 8;
            app.UIAxesRight_R_accelsr.Layout.Row = 1;
            app.UIAxesRight_R_accelsr.Layout.Column = 2;

            % Create UIAxesLeft_R_accelsr
            app.UIAxesLeft_R_accelsr = uiaxes(app.GridLayout_39);
            title(app.UIAxesLeft_R_accelsr, 'Title')
            xlabel(app.UIAxesLeft_R_accelsr, 'X')
            ylabel(app.UIAxesLeft_R_accelsr, 'Y')
            zlabel(app.UIAxesLeft_R_accelsr, 'Z')
            app.UIAxesLeft_R_accelsr.FontName = 'Times New Roman';
            app.UIAxesLeft_R_accelsr.XLim = [-4000 4000];
            app.UIAxesLeft_R_accelsr.FontSize = 8;
            app.UIAxesLeft_R_accelsr.Layout.Row = 1;
            app.UIAxesLeft_R_accelsr.Layout.Column = 1;

            % Create ResultEvaluationPanel_39
            app.ResultEvaluationPanel_39 = uipanel(app.GridLayout_39);
            app.ResultEvaluationPanel_39.BorderType = 'none';
            app.ResultEvaluationPanel_39.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_39.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_39.Layout.Row = 2;
            app.ResultEvaluationPanel_39.Layout.Column = 1;
            app.ResultEvaluationPanel_39.FontWeight = 'bold';

            % Create BewertungDropDown_39
            app.BewertungDropDown_39 = uidropdown(app.ResultEvaluationPanel_39);
            app.BewertungDropDown_39.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_39.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_39ValueChanged, true);
            app.BewertungDropDown_39.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_39.Position = [5 57 326 22];
            app.BewertungDropDown_39.Value = 'The current results meet the requirements';

            % Create Lamp_39
            app.Lamp_39 = uilamp(app.ResultEvaluationPanel_39);
            app.Lamp_39.Position = [336 58 20 20];
            app.Lamp_39.Color = [1 1 0.0667];

            % Create TextArea_40
            app.TextArea_40 = uitextarea(app.ResultEvaluationPanel_39);
            app.TextArea_40.Position = [5 3 352 50];

            % Create InfoPanel_39
            app.InfoPanel_39 = uipanel(app.GridLayout_39);
            app.InfoPanel_39.BorderType = 'none';
            app.InfoPanel_39.Title = 'Info.';
            app.InfoPanel_39.BackgroundColor = [1 1 1];
            app.InfoPanel_39.Layout.Row = 2;
            app.InfoPanel_39.Layout.Column = 2;
            app.InfoPanel_39.FontWeight = 'bold';

            % Create DatePicker_39
            app.DatePicker_39 = uidatepicker(app.InfoPanel_39);
            app.DatePicker_39.Position = [175 7 112 18];
            app.DatePicker_39.Value = datetime([2025 1 1]);

            % Create ProjectEditField_40Label
            app.ProjectEditField_40Label = uilabel(app.InfoPanel_39);
            app.ProjectEditField_40Label.HorizontalAlignment = 'right';
            app.ProjectEditField_40Label.Position = [4 57 46 22];
            app.ProjectEditField_40Label.Text = 'Project:';

            % Create ProjectEditField_40
            app.ProjectEditField_40 = uieditfield(app.InfoPanel_39, 'text');
            app.ProjectEditField_40.Position = [63 59 137 18];
            app.ProjectEditField_40.Value = 'Gestamp NRAC';

            % Create VersionEditField_39Label
            app.VersionEditField_39Label = uilabel(app.InfoPanel_39);
            app.VersionEditField_39Label.BackgroundColor = [1 1 1];
            app.VersionEditField_39Label.HorizontalAlignment = 'right';
            app.VersionEditField_39Label.Position = [4 31 48 22];
            app.VersionEditField_39Label.Text = 'Version:';

            % Create VersionEditField_39
            app.VersionEditField_39 = uieditfield(app.InfoPanel_39, 'text');
            app.VersionEditField_39.HorizontalAlignment = 'center';
            app.VersionEditField_39.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_39.Position = [63 34 77 17];
            app.VersionEditField_39.Value = 'G046';

            % Create FlexbodySwitch_39
            app.FlexbodySwitch_39 = uiswitch(app.InfoPanel_39, 'slider');
            app.FlexbodySwitch_39.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_39.FontSize = 9;
            app.FlexbodySwitch_39.Position = [219 34 35 16];
            app.FlexbodySwitch_39.Value = 'Flex-Off';

            % Create Image2_46
            app.Image2_46 = uiimage(app.InfoPanel_39);
            app.Image2_46.Position = [297 8 26 25];
            app.Image2_46.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_39Label
            app.CreatorDropDown_39Label = uilabel(app.InfoPanel_39);
            app.CreatorDropDown_39Label.FontSize = 8;
            app.CreatorDropDown_39Label.Position = [8 4 50 22];
            app.CreatorDropDown_39Label.Text = 'Creator:';

            % Create CreatorDropDown_39
            app.CreatorDropDown_39 = uidropdown(app.InfoPanel_39);
            app.CreatorDropDown_39.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_39.FontSize = 8;
            app.CreatorDropDown_39.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_39.Position = [63 7 100 16];
            app.CreatorDropDown_39.Value = 'Q. Rong';

            % Create Image9_39
            app.Image9_39 = uiimage(app.InfoPanel_39);
            app.Image9_39.Position = [328 4 30 28];
            app.Image9_39.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create AccelerationForceTestLabel_2
            app.AccelerationForceTestLabel_2 = uilabel(app.InfoPanel_39);
            app.AccelerationForceTestLabel_2.BackgroundColor = [0.4941 0.1843 0.5569];
            app.AccelerationForceTestLabel_2.HorizontalAlignment = 'right';
            app.AccelerationForceTestLabel_2.FontWeight = 'bold';
            app.AccelerationForceTestLabel_2.FontColor = [1 1 1];
            app.AccelerationForceTestLabel_2.Position = [218 55 140 22];
            app.AccelerationForceTestLabel_2.Text = 'Acceleration Force Test';

            % Create accelCasterArmTab
            app.accelCasterArmTab = uitab(app.TabGroup_R_accel_results);
            app.accelCasterArmTab.Title = 'Caster Moment Arm';

            % Create GridLayout_40
            app.GridLayout_40 = uigridlayout(app.accelCasterArmTab);
            app.GridLayout_40.ColumnWidth = {'5x', '5x'};
            app.GridLayout_40.RowHeight = {'24x', '8x'};
            app.GridLayout_40.BackgroundColor = [1 1 1];

            % Create UIAxesRight_R_accelcma
            app.UIAxesRight_R_accelcma = uiaxes(app.GridLayout_40);
            title(app.UIAxesRight_R_accelcma, 'Title')
            xlabel(app.UIAxesRight_R_accelcma, 'X')
            ylabel(app.UIAxesRight_R_accelcma, 'Y')
            zlabel(app.UIAxesRight_R_accelcma, 'Z')
            app.UIAxesRight_R_accelcma.FontName = 'Times New Roman';
            app.UIAxesRight_R_accelcma.XLim = [-4000 4000];
            app.UIAxesRight_R_accelcma.FontSize = 8;
            app.UIAxesRight_R_accelcma.Layout.Row = 1;
            app.UIAxesRight_R_accelcma.Layout.Column = 2;

            % Create UIAxesLeft_R_accelcma
            app.UIAxesLeft_R_accelcma = uiaxes(app.GridLayout_40);
            title(app.UIAxesLeft_R_accelcma, 'Title')
            xlabel(app.UIAxesLeft_R_accelcma, 'X')
            ylabel(app.UIAxesLeft_R_accelcma, 'Y')
            zlabel(app.UIAxesLeft_R_accelcma, 'Z')
            app.UIAxesLeft_R_accelcma.FontName = 'Times New Roman';
            app.UIAxesLeft_R_accelcma.XLim = [-4000 4000];
            app.UIAxesLeft_R_accelcma.FontSize = 8;
            app.UIAxesLeft_R_accelcma.Layout.Row = 1;
            app.UIAxesLeft_R_accelcma.Layout.Column = 1;

            % Create ResultEvaluationPanel_40
            app.ResultEvaluationPanel_40 = uipanel(app.GridLayout_40);
            app.ResultEvaluationPanel_40.BorderType = 'none';
            app.ResultEvaluationPanel_40.Title = 'Result Evaluation：';
            app.ResultEvaluationPanel_40.BackgroundColor = [1 1 1];
            app.ResultEvaluationPanel_40.Layout.Row = 2;
            app.ResultEvaluationPanel_40.Layout.Column = 1;
            app.ResultEvaluationPanel_40.FontWeight = 'bold';

            % Create BewertungDropDown_40
            app.BewertungDropDown_40 = uidropdown(app.ResultEvaluationPanel_40);
            app.BewertungDropDown_40.Items = {'The current results meet the requirements', 'The current results need further optimization.', 'The current results have serious issues.'};
            app.BewertungDropDown_40.ValueChangedFcn = createCallbackFcn(app, @BewertungDropDown_40ValueChanged, true);
            app.BewertungDropDown_40.BackgroundColor = [0.9412 0.9686 0.9882];
            app.BewertungDropDown_40.Position = [5 57 326 22];
            app.BewertungDropDown_40.Value = 'The current results meet the requirements';

            % Create Lamp_40
            app.Lamp_40 = uilamp(app.ResultEvaluationPanel_40);
            app.Lamp_40.Position = [336 58 20 20];
            app.Lamp_40.Color = [1 1 0.0667];

            % Create TextArea_41
            app.TextArea_41 = uitextarea(app.ResultEvaluationPanel_40);
            app.TextArea_41.Position = [5 3 352 50];

            % Create InfoPanel_40
            app.InfoPanel_40 = uipanel(app.GridLayout_40);
            app.InfoPanel_40.BorderType = 'none';
            app.InfoPanel_40.Title = 'Info.';
            app.InfoPanel_40.BackgroundColor = [1 1 1];
            app.InfoPanel_40.Layout.Row = 2;
            app.InfoPanel_40.Layout.Column = 2;
            app.InfoPanel_40.FontWeight = 'bold';

            % Create DatePicker_40
            app.DatePicker_40 = uidatepicker(app.InfoPanel_40);
            app.DatePicker_40.Position = [175 7 112 18];
            app.DatePicker_40.Value = datetime([2025 1 1]);

            % Create ProjectEditField_41Label
            app.ProjectEditField_41Label = uilabel(app.InfoPanel_40);
            app.ProjectEditField_41Label.HorizontalAlignment = 'right';
            app.ProjectEditField_41Label.Position = [4 57 46 22];
            app.ProjectEditField_41Label.Text = 'Project:';

            % Create ProjectEditField_41
            app.ProjectEditField_41 = uieditfield(app.InfoPanel_40, 'text');
            app.ProjectEditField_41.Position = [63 59 137 18];
            app.ProjectEditField_41.Value = 'Gestamp NRAC';

            % Create VersionEditField_40Label
            app.VersionEditField_40Label = uilabel(app.InfoPanel_40);
            app.VersionEditField_40Label.BackgroundColor = [1 1 1];
            app.VersionEditField_40Label.HorizontalAlignment = 'right';
            app.VersionEditField_40Label.Position = [4 31 48 22];
            app.VersionEditField_40Label.Text = 'Version:';

            % Create VersionEditField_40
            app.VersionEditField_40 = uieditfield(app.InfoPanel_40, 'text');
            app.VersionEditField_40.HorizontalAlignment = 'center';
            app.VersionEditField_40.BackgroundColor = [0.9843 0.9608 1];
            app.VersionEditField_40.Position = [63 34 77 17];
            app.VersionEditField_40.Value = 'G046';

            % Create FlexbodySwitch_40
            app.FlexbodySwitch_40 = uiswitch(app.InfoPanel_40, 'slider');
            app.FlexbodySwitch_40.Items = {'Flex-Off', 'Flex-On'};
            app.FlexbodySwitch_40.FontSize = 9;
            app.FlexbodySwitch_40.Position = [219 34 35 16];
            app.FlexbodySwitch_40.Value = 'Flex-Off';

            % Create Image2_47
            app.Image2_47 = uiimage(app.InfoPanel_40);
            app.Image2_47.Position = [297 8 26 25];
            app.Image2_47.ImageSource = fullfile(pathToMLAPP, 'matlab-logo.png');

            % Create CreatorDropDown_40Label
            app.CreatorDropDown_40Label = uilabel(app.InfoPanel_40);
            app.CreatorDropDown_40Label.FontSize = 8;
            app.CreatorDropDown_40Label.Position = [8 4 50 22];
            app.CreatorDropDown_40Label.Text = 'Creator:';

            % Create CreatorDropDown_40
            app.CreatorDropDown_40 = uidropdown(app.InfoPanel_40);
            app.CreatorDropDown_40.Items = {'Q. Rong', 'Option 2', 'Option 3', 'Option 4'};
            app.CreatorDropDown_40.FontSize = 8;
            app.CreatorDropDown_40.BackgroundColor = [0.9451 0.9804 0.9412];
            app.CreatorDropDown_40.Position = [63 7 100 16];
            app.CreatorDropDown_40.Value = 'Q. Rong';

            % Create Image9_40
            app.Image9_40 = uiimage(app.InfoPanel_40);
            app.Image9_40.Position = [328 4 30 28];
            app.Image9_40.ImageSource = fullfile(pathToMLAPP, 'gestamp_logo_small1.png');

            % Create AccelerationForceTestLabel
            app.AccelerationForceTestLabel = uilabel(app.InfoPanel_40);
            app.AccelerationForceTestLabel.BackgroundColor = [0.4941 0.1843 0.5569];
            app.AccelerationForceTestLabel.HorizontalAlignment = 'right';
            app.AccelerationForceTestLabel.FontWeight = 'bold';
            app.AccelerationForceTestLabel.FontColor = [1 1 1];
            app.AccelerationForceTestLabel.Position = [218 55 140 22];
            app.AccelerationForceTestLabel.Text = 'Acceleration Force Test';

            % Create ResultsPanel_R_accel
            app.ResultsPanel_R_accel = uipanel(app.Tab_KcRear_Accel);
            app.ResultsPanel_R_accel.BorderWidth = 0.5;
            app.ResultsPanel_R_accel.Title = 'Results';
            app.ResultsPanel_R_accel.BackgroundColor = [1 1 1];
            app.ResultsPanel_R_accel.FontName = 'Times New Roman';
            app.ResultsPanel_R_accel.Position = [19 11 275 468];

            % Create GridLayout3_4
            app.GridLayout3_4 = uigridlayout(app.ResultsPanel_R_accel);
            app.GridLayout3_4.ColumnWidth = {100, 55, 100};
            app.GridLayout3_4.RowHeight = {18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 20, '1x', 4};
            app.GridLayout3_4.ColumnSpacing = 4.5;
            app.GridLayout3_4.RowSpacing = 5.58823529411765;
            app.GridLayout3_4.Padding = [4.5 5.58823529411765 4.5 5.58823529411765];
            app.GridLayout3_4.BackgroundColor = [1 1 1];

            % Create Label_12
            app.Label_12 = uilabel(app.GridLayout3_4);
            app.Label_12.HorizontalAlignment = 'center';
            app.Label_12.FontName = 'Times New Roman';
            app.Label_12.FontSize = 8;
            app.Label_12.Layout.Row = 2;
            app.Label_12.Layout.Column = 3;
            app.Label_12.Text = '[-0.02 ~ +0.04]';

            % Create tbdLabel_22
            app.tbdLabel_22 = uilabel(app.GridLayout3_4);
            app.tbdLabel_22.HorizontalAlignment = 'center';
            app.tbdLabel_22.FontName = 'Times New Roman';
            app.tbdLabel_22.Layout.Row = 4;
            app.tbdLabel_22.Layout.Column = 3;
            app.tbdLabel_22.Text = '[t. b. d.]';

            % Create tbdLabel_23
            app.tbdLabel_23 = uilabel(app.GridLayout3_4);
            app.tbdLabel_23.HorizontalAlignment = 'center';
            app.tbdLabel_23.FontName = 'Times New Roman';
            app.tbdLabel_23.Layout.Row = 6;
            app.tbdLabel_23.Layout.Column = 3;
            app.tbdLabel_23.Text = '[t. b. d.]';

            % Create tbdLabel_24
            app.tbdLabel_24 = uilabel(app.GridLayout3_4);
            app.tbdLabel_24.HorizontalAlignment = 'center';
            app.tbdLabel_24.FontName = 'Times New Roman';
            app.tbdLabel_24.Layout.Row = 8;
            app.tbdLabel_24.Layout.Column = 3;
            app.tbdLabel_24.Text = '[t. b. d.]';

            % Create tbdLabel_25
            app.tbdLabel_25 = uilabel(app.GridLayout3_4);
            app.tbdLabel_25.HorizontalAlignment = 'center';
            app.tbdLabel_25.FontName = 'Times New Roman';
            app.tbdLabel_25.Layout.Row = 10;
            app.tbdLabel_25.Layout.Column = 3;
            app.tbdLabel_25.Text = '[t. b. d.]';

            % Create tbdLabel_26
            app.tbdLabel_26 = uilabel(app.GridLayout3_4);
            app.tbdLabel_26.HorizontalAlignment = 'center';
            app.tbdLabel_26.FontName = 'Times New Roman';
            app.tbdLabel_26.Layout.Row = 12;
            app.tbdLabel_26.Layout.Column = 3;
            app.tbdLabel_26.Text = '[t. b. d.]';

            % Create tbdLabel_27
            app.tbdLabel_27 = uilabel(app.GridLayout3_4);
            app.tbdLabel_27.HorizontalAlignment = 'center';
            app.tbdLabel_27.FontName = 'Times New Roman';
            app.tbdLabel_27.Layout.Row = 14;
            app.tbdLabel_27.Layout.Column = 3;
            app.tbdLabel_27.Text = '[t. b. d.]';

            % Create tbdLabel_28
            app.tbdLabel_28 = uilabel(app.GridLayout3_4);
            app.tbdLabel_28.HorizontalAlignment = 'center';
            app.tbdLabel_28.FontName = 'Times New Roman';
            app.tbdLabel_28.Layout.Row = 16;
            app.tbdLabel_28.Layout.Column = 3;
            app.tbdLabel_28.Text = '[t. b. d.]';

            % Create LatForceToeChangeLabel_5
            app.LatForceToeChangeLabel_5 = uilabel(app.GridLayout3_4);
            app.LatForceToeChangeLabel_5.VerticalAlignment = 'bottom';
            app.LatForceToeChangeLabel_5.FontName = 'Times New Roman';
            app.LatForceToeChangeLabel_5.Layout.Row = 1;
            app.LatForceToeChangeLabel_5.Layout.Column = [1 2];
            app.LatForceToeChangeLabel_5.Text = 'Drive Steer Change';

            % Create acceltoeEditField
            app.acceltoeEditField = uieditfield(app.GridLayout3_4, 'numeric');
            app.acceltoeEditField.FontName = 'Times New Roman';
            app.acceltoeEditField.Layout.Row = 2;
            app.acceltoeEditField.Layout.Column = 1;

            % Create LatForceToeChangeLabel_6
            app.LatForceToeChangeLabel_6 = uilabel(app.GridLayout3_4);
            app.LatForceToeChangeLabel_6.VerticalAlignment = 'bottom';
            app.LatForceToeChangeLabel_6.FontName = 'Times New Roman';
            app.LatForceToeChangeLabel_6.Layout.Row = 3;
            app.LatForceToeChangeLabel_6.Layout.Column = [1 2];
            app.LatForceToeChangeLabel_6.Text = 'Anti-Squat Acceleration';

            % Create accelantidiveEditField
            app.accelantidiveEditField = uieditfield(app.GridLayout3_4, 'numeric');
            app.accelantidiveEditField.FontName = 'Times New Roman';
            app.accelantidiveEditField.Layout.Row = 4;
            app.accelantidiveEditField.Layout.Column = 1;

            % Create BrakeCamberChangeLabel_2
            app.BrakeCamberChangeLabel_2 = uilabel(app.GridLayout3_4);
            app.BrakeCamberChangeLabel_2.VerticalAlignment = 'bottom';
            app.BrakeCamberChangeLabel_2.FontName = 'Times New Roman';
            app.BrakeCamberChangeLabel_2.Layout.Row = 5;
            app.BrakeCamberChangeLabel_2.Layout.Column = [1 2];
            app.BrakeCamberChangeLabel_2.Text = 'Drive Camber Change';

            % Create accelcamberEditField
            app.accelcamberEditField = uieditfield(app.GridLayout3_4, 'numeric');
            app.accelcamberEditField.FontName = 'Times New Roman';
            app.accelcamberEditField.Layout.Row = 6;
            app.accelcamberEditField.Layout.Column = 1;

            % Create LatForceComplianceWCLabel_3
            app.LatForceComplianceWCLabel_3 = uilabel(app.GridLayout3_4);
            app.LatForceComplianceWCLabel_3.VerticalAlignment = 'bottom';
            app.LatForceComplianceWCLabel_3.FontName = 'Times New Roman';
            app.LatForceComplianceWCLabel_3.Layout.Row = 7;
            app.LatForceComplianceWCLabel_3.Layout.Column = [1 2];
            app.LatForceComplianceWCLabel_3.Text = 'Drive Wheel Recession @WC';

            % Create accelcompEditField
            app.accelcompEditField = uieditfield(app.GridLayout3_4, 'numeric');
            app.accelcompEditField.FontName = 'Times New Roman';
            app.accelcompEditField.Layout.Row = 8;
            app.accelcompEditField.Layout.Column = 1;

            % Create KingpinCasterAngleLabel_3
            app.KingpinCasterAngleLabel_3 = uilabel(app.GridLayout3_4);
            app.KingpinCasterAngleLabel_3.FontName = 'Times New Roman';
            app.KingpinCasterAngleLabel_3.Layout.Row = 9;
            app.KingpinCasterAngleLabel_3.Layout.Column = [1 2];
            app.KingpinCasterAngleLabel_3.Text = 'Kingpin Caster Angle';

            % Create accelspinEditField
            app.accelspinEditField = uieditfield(app.GridLayout3_4, 'numeric');
            app.accelspinEditField.FontName = 'Times New Roman';
            app.accelspinEditField.Layout.Row = 10;
            app.accelspinEditField.Layout.Column = 1;

            % Create KingpinInclinationAngleLabel_3
            app.KingpinInclinationAngleLabel_3 = uilabel(app.GridLayout3_4);
            app.KingpinInclinationAngleLabel_3.FontName = 'Times New Roman';
            app.KingpinInclinationAngleLabel_3.Layout.Row = 11;
            app.KingpinInclinationAngleLabel_3.Layout.Column = [1 2];
            app.KingpinInclinationAngleLabel_3.Text = 'Kingpin Inclination Angle';

            % Create accelincEditField
            app.accelincEditField = uieditfield(app.GridLayout3_4, 'numeric');
            app.accelincEditField.FontName = 'Times New Roman';
            app.accelincEditField.Layout.Row = 12;
            app.accelincEditField.Layout.Column = 1;

            % Create ScrubRadiusLabel_3
            app.ScrubRadiusLabel_3 = uilabel(app.GridLayout3_4);
            app.ScrubRadiusLabel_3.VerticalAlignment = 'bottom';
            app.ScrubRadiusLabel_3.FontName = 'Times New Roman';
            app.ScrubRadiusLabel_3.Layout.Row = 13;
            app.ScrubRadiusLabel_3.Layout.Column = [1 2];
            app.ScrubRadiusLabel_3.Text = 'Scrub Radius';

            % Create accelsrEditField
            app.accelsrEditField = uieditfield(app.GridLayout3_4, 'numeric');
            app.accelsrEditField.FontName = 'Times New Roman';
            app.accelsrEditField.Layout.Row = 14;
            app.accelsrEditField.Layout.Column = 1;

            % Create CasterMomentArmLabel_3
            app.CasterMomentArmLabel_3 = uilabel(app.GridLayout3_4);
            app.CasterMomentArmLabel_3.VerticalAlignment = 'bottom';
            app.CasterMomentArmLabel_3.FontName = 'Times New Roman';
            app.CasterMomentArmLabel_3.Layout.Row = 15;
            app.CasterMomentArmLabel_3.Layout.Column = 1;
            app.CasterMomentArmLabel_3.Text = 'Caster Moment Arm';

            % Create accelcmaEditField
            app.accelcmaEditField = uieditfield(app.GridLayout3_4, 'numeric');
            app.accelcmaEditField.FontName = 'Times New Roman';
            app.accelcmaEditField.Layout.Row = 16;
            app.accelcmaEditField.Layout.Column = 1;

            % Create kNLabel_7
            app.kNLabel_7 = uilabel(app.GridLayout3_4);
            app.kNLabel_7.HorizontalAlignment = 'center';
            app.kNLabel_7.FontName = 'Times New Roman';
            app.kNLabel_7.Layout.Row = 2;
            app.kNLabel_7.Layout.Column = 2;
            app.kNLabel_7.Text = '°/kN';

            % Create Label_13
            app.Label_13 = uilabel(app.GridLayout3_4);
            app.Label_13.HorizontalAlignment = 'center';
            app.Label_13.FontName = 'Times New Roman';
            app.Label_13.Layout.Row = 4;
            app.Label_13.Layout.Column = 2;
            app.Label_13.Text = '%';

            % Create kNLabel_8
            app.kNLabel_8 = uilabel(app.GridLayout3_4);
            app.kNLabel_8.HorizontalAlignment = 'center';
            app.kNLabel_8.FontName = 'Times New Roman';
            app.kNLabel_8.Layout.Row = 6;
            app.kNLabel_8.Layout.Column = 2;
            app.kNLabel_8.Text = '°/kN';

            % Create mmkNLabel_3
            app.mmkNLabel_3 = uilabel(app.GridLayout3_4);
            app.mmkNLabel_3.HorizontalAlignment = 'center';
            app.mmkNLabel_3.FontName = 'Times New Roman';
            app.mmkNLabel_3.Layout.Row = 8;
            app.mmkNLabel_3.Layout.Column = 2;
            app.mmkNLabel_3.Text = 'mm/kN';

            % Create Label_14
            app.Label_14 = uilabel(app.GridLayout3_4);
            app.Label_14.HorizontalAlignment = 'center';
            app.Label_14.FontName = 'Times New Roman';
            app.Label_14.Layout.Row = 10;
            app.Label_14.Layout.Column = 2;
            app.Label_14.Text = '°';

            % Create Label_15
            app.Label_15 = uilabel(app.GridLayout3_4);
            app.Label_15.HorizontalAlignment = 'center';
            app.Label_15.FontName = 'Times New Roman';
            app.Label_15.Layout.Row = 12;
            app.Label_15.Layout.Column = 2;
            app.Label_15.Text = '°';

            % Create mmLabel_14
            app.mmLabel_14 = uilabel(app.GridLayout3_4);
            app.mmLabel_14.HorizontalAlignment = 'center';
            app.mmLabel_14.FontName = 'Times New Roman';
            app.mmLabel_14.Layout.Row = 14;
            app.mmLabel_14.Layout.Column = 2;
            app.mmLabel_14.Text = 'mm';

            % Create mmLabel_15
            app.mmLabel_15 = uilabel(app.GridLayout3_4);
            app.mmLabel_15.HorizontalAlignment = 'center';
            app.mmLabel_15.FontName = 'Times New Roman';
            app.mmLabel_15.Layout.Row = 16;
            app.mmLabel_15.Layout.Column = 2;
            app.mmLabel_15.Text = 'mm';

            % Create AccelClearAxesButton
            app.AccelClearAxesButton = uibutton(app.GridLayout3_4, 'push');
            app.AccelClearAxesButton.ButtonPushedFcn = createCallbackFcn(app, @AccelClearAxesButtonPushed, true);
            app.AccelClearAxesButton.Layout.Row = 18;
            app.AccelClearAxesButton.Layout.Column = 3;
            app.AccelClearAxesButton.Text = 'Plot Clear';

            % Create PositivDirectionButton_5
            app.PositivDirectionButton_5 = uibutton(app.GridLayout3_4, 'push');
            app.PositivDirectionButton_5.Layout.Row = 18;
            app.PositivDirectionButton_5.Layout.Column = 1;
            app.PositivDirectionButton_5.Text = 'Positiv Direction';

            % Create NRACTargetLabel_4
            app.NRACTargetLabel_4 = uilabel(app.GridLayout3_4);
            app.NRACTargetLabel_4.FontName = 'Times New Roman';
            app.NRACTargetLabel_4.Layout.Row = 1;
            app.NRACTargetLabel_4.Layout.Column = 3;
            app.NRACTargetLabel_4.Text = 'NRAC Target';

            % Create GOButton_R_accel
            app.GOButton_R_accel = uibutton(app.Tab_KcRear_Accel, 'push');
            app.GOButton_R_accel.ButtonPushedFcn = createCallbackFcn(app, @GOButton_R_accelPushed, true);
            app.GOButton_R_accel.Tag = 'executeFunctionButton';
            app.GOButton_R_accel.Position = [740 500 100 23];
            app.GOButton_R_accel.Text = 'GO!';

            % Create Button_browser_R_accel
            app.Button_browser_R_accel = uibutton(app.Tab_KcRear_Accel, 'push');
            app.Button_browser_R_accel.ButtonPushedFcn = createCallbackFcn(app, @Button_browser_R_accelPushed, true);
            app.Button_browser_R_accel.Tag = 'selectFileButton';
            app.Button_browser_R_accel.Position = [19 500 100 23];
            app.Button_browser_R_accel.Text = 'Select File ...';

            % Create CurrentFileLabel_5
            app.CurrentFileLabel_5 = uilabel(app.Tab_KcRear_Accel);
            app.CurrentFileLabel_5.HorizontalAlignment = 'right';
            app.CurrentFileLabel_5.Position = [124 500 70 22];
            app.CurrentFileLabel_5.Text = 'Current File:';

            % Create EditField_browser_R_accel
            app.EditField_browser_R_accel = uieditfield(app.Tab_KcRear_Accel, 'text');
            app.EditField_browser_R_accel.Tag = 'filePathEditField';
            app.EditField_browser_R_accel.Position = [209 500 512 22];

            % Create FittingRangeKnob_2Label_4
            app.FittingRangeKnob_2Label_4 = uilabel(app.Tab_KcRear_Accel);
            app.FittingRangeKnob_2Label_4.HorizontalAlignment = 'center';
            app.FittingRangeKnob_2Label_4.FontName = 'Times New Roman';
            app.FittingRangeKnob_2Label_4.FontSize = 8;
            app.FittingRangeKnob_2Label_4.Position = [866 512 77 22];
            app.FittingRangeKnob_2Label_4.Text = 'Fitting Range=';

            % Create FittingRangeKnob_R_accel
            app.FittingRangeKnob_R_accel = uiknob(app.Tab_KcRear_Accel, 'discrete');
            app.FittingRangeKnob_R_accel.Items = {'100', '200', '300', '400', '500'};
            app.FittingRangeKnob_R_accel.ValueChangedFcn = createCallbackFcn(app, @FittingRangeKnob_R_accelValueChanged, true);
            app.FittingRangeKnob_R_accel.FontName = 'Times New Roman';
            app.FittingRangeKnob_R_accel.FontSize = 8;
            app.FittingRangeKnob_R_accel.Position = [1004 484 33 33];
            app.FittingRangeKnob_R_accel.Value = '500';

            % Create BYDDelphinButton_10
            app.BYDDelphinButton_10 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.BYDDelphinButton_10.Text = 'BYD Delphin';
            app.BYDDelphinButton_10.Position = [1075 430 88 23];

            % Create VWPassatButton_10
            app.VWPassatButton_10 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.VWPassatButton_10.Text = 'VW Passat';
            app.VWPassatButton_10.Position = [1075 404 88 23];

            % Create TeslaModel3Button_10
            app.TeslaModel3Button_10 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.TeslaModel3Button_10.Text = 'Tesla Model 3';
            app.TeslaModel3Button_10.Position = [1075 293 89 23];

            % Create FORDEDGEButton_10
            app.FORDEDGEButton_10 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.FORDEDGEButton_10.Text = 'FORD EDGE';
            app.FORDEDGEButton_10.Position = [1075 378 88 23];

            % Create RefVehicleLabel_10
            app.RefVehicleLabel_10 = uilabel(app.Tab_KcRear_Accel);
            app.RefVehicleLabel_10.FontWeight = 'bold';
            app.RefVehicleLabel_10.Position = [1081 510 72 22];
            app.RefVehicleLabel_10.Text = 'Ref. Vehicle';

            % Create ABDSPMMPlusLabel_13
            app.ABDSPMMPlusLabel_13 = uilabel(app.Tab_KcRear_Accel);
            app.ABDSPMMPlusLabel_13.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_13.FontSize = 10;
            app.ABDSPMMPlusLabel_13.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_13.Position = [1069 480 108 22];
            app.ABDSPMMPlusLabel_13.Text = '* ABD SPMM Plus';

            % Create TestBenchResultsLabel_5
            app.TestBenchResultsLabel_5 = uilabel(app.Tab_KcRear_Accel);
            app.TestBenchResultsLabel_5.FontName = 'Times New Roman';
            app.TestBenchResultsLabel_5.FontSize = 10;
            app.TestBenchResultsLabel_5.FontAngle = 'italic';
            app.TestBenchResultsLabel_5.Position = [1069 459 108 22];
            app.TestBenchResultsLabel_5.Text = '   Test Bench Results';

            % Create ABDSPMMPlusLabel_14
            app.ABDSPMMPlusLabel_14 = uilabel(app.Tab_KcRear_Accel);
            app.ABDSPMMPlusLabel_14.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_14.FontSize = 10;
            app.ABDSPMMPlusLabel_14.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_14.Position = [1069 343 108 22];
            app.ABDSPMMPlusLabel_14.Text = '* ABD SPMM Plus';

            % Create TestReportLabel_5
            app.TestReportLabel_5 = uilabel(app.Tab_KcRear_Accel);
            app.TestReportLabel_5.FontName = 'Times New Roman';
            app.TestReportLabel_5.FontSize = 10;
            app.TestReportLabel_5.FontAngle = 'italic';
            app.TestReportLabel_5.Position = [1069 322 108 22];
            app.TestReportLabel_5.Text = '   Test Report';

            % Create VWID3Button_5
            app.VWID3Button_5 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.VWID3Button_5.Text = 'VW ID.3';
            app.VWID3Button_5.Position = [1075 267 89 23];

            % Create BMW325iButton_5
            app.BMW325iButton_5 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.BMW325iButton_5.Text = 'BMW 325i';
            app.BMW325iButton_5.Position = [1075 241 89 23];

            % Create TOYOTAYarisButton_5
            app.TOYOTAYarisButton_5 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.TOYOTAYarisButton_5.Text = 'TOYOTA Yaris';
            app.TOYOTAYarisButton_5.Position = [1075 79 89 23];

            % Create BYDDolphinButton_5
            app.BYDDolphinButton_5 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.BYDDolphinButton_5.Text = 'BYD Dolphin';
            app.BYDDolphinButton_5.Position = [1075 157 89 23];

            % Create ABDSPMMPlusLabel_15
            app.ABDSPMMPlusLabel_15 = uilabel(app.Tab_KcRear_Accel);
            app.ABDSPMMPlusLabel_15.FontName = 'Times New Roman';
            app.ABDSPMMPlusLabel_15.FontSize = 10;
            app.ABDSPMMPlusLabel_15.FontAngle = 'italic';
            app.ABDSPMMPlusLabel_15.Position = [1069 207 108 22];
            app.ABDSPMMPlusLabel_15.Text = '* ABD SPMM Plus';

            % Create TwistBeamLabel_5
            app.TwistBeamLabel_5 = uilabel(app.Tab_KcRear_Accel);
            app.TwistBeamLabel_5.FontName = 'Times New Roman';
            app.TwistBeamLabel_5.FontSize = 10;
            app.TwistBeamLabel_5.FontAngle = 'italic';
            app.TwistBeamLabel_5.Position = [1069 186 108 22];
            app.TwistBeamLabel_5.Text = '   TwistBeam';

            % Create VWGolfButton_6
            app.VWGolfButton_6 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.VWGolfButton_6.Text = 'VW Golf';
            app.VWGolfButton_6.Position = [1075 131 89 23];

            % Create VWUPButton_5
            app.VWUPButton_5 = uibutton(app.Tab_KcRear_Accel, 'state');
            app.VWUPButton_5.Text = 'VW UP!';
            app.VWUPButton_5.Position = [1075 105 89 23];

            % Create Button_9
            app.Button_9 = uibutton(app.Tab_KcRear_Accel, 'push');
            app.Button_9.Icon = fullfile(pathToMLAPP, 'Icon_plot_custerm.png');
            app.Button_9.Position = [1075 11 40 41];
            app.Button_9.Text = '';

            % Create Button_10
            app.Button_10 = uibutton(app.Tab_KcRear_Accel, 'push');
            app.Button_10.Icon = fullfile(pathToMLAPP, 'icon_to_ppt.png');
            app.Button_10.Position = [1127 12 37 40];
            app.Button_10.Text = '';

            % Create Tab_KcRear_AlignTorque
            app.Tab_KcRear_AlignTorque = uitab(app.Tab_KcRear);
            app.Tab_KcRear_AlignTorque.Title = 'Align Torque';

            % Create BYDDelphinButton_6
            app.BYDDelphinButton_6 = uibutton(app.Tab_KcRear_AlignTorque, 'state');
            app.BYDDelphinButton_6.Text = 'BYD Delphin';
            app.BYDDelphinButton_6.Position = [1067 399 88 23];

            % Create VWPassatButton_6
            app.VWPassatButton_6 = uibutton(app.Tab_KcRear_AlignTorque, 'state');
            app.VWPassatButton_6.Text = 'VW Passat';
            app.VWPassatButton_6.Position = [1067 363 88 23];

            % Create TeslaModel3Button_6
            app.TeslaModel3Button_6 = uibutton(app.Tab_KcRear_AlignTorque, 'state');
            app.TeslaModel3Button_6.Text = 'Tesla Model 3';
            app.TeslaModel3Button_6.Position = [1067 326 89 23];

            % Create FORDEDGEButton_6
            app.FORDEDGEButton_6 = uibutton(app.Tab_KcRear_AlignTorque, 'state');
            app.FORDEDGEButton_6.Text = 'FORD EDGE';
            app.FORDEDGEButton_6.Position = [1067 288 88 23];

            % Create RefVehicleLabel_6
            app.RefVehicleLabel_6 = uilabel(app.Tab_KcRear_AlignTorque);
            app.RefVehicleLabel_6.Position = [1078 436 68 22];
            app.RefVehicleLabel_6.Text = 'Ref. Vehicle';

            % Create SaveResultsinPPTButton
            app.SaveResultsinPPTButton = uibutton(app.Tab_KC_rear, 'push');
            app.SaveResultsinPPTButton.Position = [15 10 123 23];
            app.SaveResultsinPPTButton.Text = 'Save Results in PPT';

            % Create SaveResultsinEXCELButton
            app.SaveResultsinEXCELButton = uibutton(app.Tab_KC_rear, 'push');
            app.SaveResultsinEXCELButton.Position = [154 10 138 23];
            app.SaveResultsinEXCELButton.Text = 'Save Results in EXCEL';

            % Create AddResultsButton
            app.AddResultsButton = uibutton(app.Tab_KC_rear, 'push');
            app.AddResultsButton.Position = [985 10 89 23];
            app.AddResultsButton.Text = 'Add Results ...';

            % Create ColorPicker_curve
            app.ColorPicker_curve = uicolorpicker(app.Tab_KC_rear);
            app.ColorPicker_curve.ValueChangedFcn = createCallbackFcn(app, @ColorPicker_curveValueChanged, true);
            app.ColorPicker_curve.Position = [848 10 38 22];

            % Create ColorPicker_fit
            app.ColorPicker_fit = uicolorpicker(app.Tab_KC_rear);
            app.ColorPicker_fit.Value = [0 0 0];
            app.ColorPicker_fit.Position = [934 10 38 22];

            % Create CurveLabel
            app.CurveLabel = uilabel(app.Tab_KC_rear);
            app.CurveLabel.Position = [810 10 37 22];
            app.CurveLabel.Text = 'Curve';

            % Create FittingLabel
            app.FittingLabel = uilabel(app.Tab_KC_rear);
            app.FittingLabel.Position = [897 10 38 22];
            app.FittingLabel.Text = 'Fitting';

            % Create toCompareSpinnerLabel
            app.toCompareSpinnerLabel = uilabel(app.Tab_KC_rear);
            app.toCompareSpinnerLabel.HorizontalAlignment = 'right';
            app.toCompareSpinnerLabel.Position = [676 10 69 22];
            app.toCompareSpinnerLabel.Text = 'to Compare';

            % Create toCompareSpinner
            app.toCompareSpinner = uispinner(app.Tab_KC_rear);
            app.toCompareSpinner.BackgroundColor = [0.902 0.902 0.902];
            app.toCompareSpinner.Position = [752 10 47 22];

            % Create ResetButton
            app.ResetButton = uibutton(app.Tab_KC_rear, 'push');
            app.ResetButton.Position = [1093 10 89 23];
            app.ResetButton.Text = 'Reset';

            % Create AllKnCfinishedthenoutputChassisSynthesisToolButton
            app.AllKnCfinishedthenoutputChassisSynthesisToolButton = uibutton(app.Tab_KC_rear, 'push');
            app.AllKnCfinishedthenoutputChassisSynthesisToolButton.Position = [326 10 343 23];
            app.AllKnCfinishedthenoutputChassisSynthesisToolButton.Text = 'All KnC finished then output >>>>>> Chassis Synthesis Tool';

            % Create Tab_KC_front
            app.Tab_KC_front = uitab(app.TabGroup_KC_bench);
            app.Tab_KC_front.Title = 'Front Suspension';

            % Create BatchAllFrontSuspensionTab
            app.BatchAllFrontSuspensionTab = uitab(app.TabGroup_KC_bench);
            app.BatchAllFrontSuspensionTab.Title = 'Batch All Front Suspension';

            % Create BatchAllRearSuspensionTab
            app.BatchAllRearSuspensionTab = uitab(app.TabGroup_KC_bench);
            app.BatchAllRearSuspensionTab.Title = 'Batch All Rear Suspension';

            % Create VariantandCoordinateSysTab
            app.VariantandCoordinateSysTab = uitab(app.TabGroup_KC_bench);
            app.VariantandCoordinateSysTab.Title = 'Variant and Coordinate Sys.';

            % Create TabGroup_vehicle
            app.TabGroup_vehicle = uitabgroup(app.UIFigure);
            app.TabGroup_vehicle.Position = [14 49 186 640];

            % Create Tab_vehicle_parameter
            app.Tab_vehicle_parameter = uitab(app.TabGroup_vehicle);
            app.Tab_vehicle_parameter.Title = 'Paramter';
            app.Tab_vehicle_parameter.BackgroundColor = [0.9412 0.9412 0.9412];

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.Tab_vehicle_parameter);
            app.GridLayout2.ColumnWidth = {66, '1x', 30};
            app.GridLayout2.RowHeight = {20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20};
            app.GridLayout2.BackgroundColor = [1 1 1];

            % Create HalfLoadLabel
            app.HalfLoadLabel = uilabel(app.GridLayout2);
            app.HalfLoadLabel.FontName = 'Times New Roman';
            app.HalfLoadLabel.Layout.Row = 15;
            app.HalfLoadLabel.Layout.Column = 1;
            app.HalfLoadLabel.Text = 'Half Load';

            % Create HalfLoadEditField
            app.HalfLoadEditField = uieditfield(app.GridLayout2, 'numeric');
            app.HalfLoadEditField.FontName = 'Times New Roman';
            app.HalfLoadEditField.Layout.Row = 15;
            app.HalfLoadEditField.Layout.Column = 2;
            app.HalfLoadEditField.Value = 1000;

            % Create MaxLoadLabel
            app.MaxLoadLabel = uilabel(app.GridLayout2);
            app.MaxLoadLabel.FontName = 'Times New Roman';
            app.MaxLoadLabel.Layout.Row = 16;
            app.MaxLoadLabel.Layout.Column = 1;
            app.MaxLoadLabel.Text = 'Max. Load';

            % Create MaxLoadEditField
            app.MaxLoadEditField = uieditfield(app.GridLayout2, 'numeric');
            app.MaxLoadEditField.FontName = 'Times New Roman';
            app.MaxLoadEditField.Layout.Row = 16;
            app.MaxLoadEditField.Layout.Column = 2;
            app.MaxLoadEditField.Value = 1250;

            % Create UnsprungLabel
            app.UnsprungLabel = uilabel(app.GridLayout2);
            app.UnsprungLabel.FontName = 'Times New Roman';
            app.UnsprungLabel.Layout.Row = 17;
            app.UnsprungLabel.Layout.Column = 1;
            app.UnsprungLabel.Text = 'Unsprung ';

            % Create UnsprungEditField
            app.UnsprungEditField = uieditfield(app.GridLayout2, 'numeric');
            app.UnsprungEditField.FontName = 'Times New Roman';
            app.UnsprungEditField.Layout.Row = 17;
            app.UnsprungEditField.Layout.Column = 2;
            app.UnsprungEditField.Value = 78;

            % Create WheelBaseLabel
            app.WheelBaseLabel = uilabel(app.GridLayout2);
            app.WheelBaseLabel.FontName = 'Times New Roman';
            app.WheelBaseLabel.Layout.Row = 5;
            app.WheelBaseLabel.Layout.Column = 1;
            app.WheelBaseLabel.Text = 'Wheel Base';

            % Create WheelBaseEditField
            app.WheelBaseEditField = uieditfield(app.GridLayout2, 'numeric');
            app.WheelBaseEditField.FontName = 'Times New Roman';
            app.WheelBaseEditField.Layout.Row = 5;
            app.WheelBaseEditField.Layout.Column = 2;
            app.WheelBaseEditField.Value = 2750;

            % Create RollAngleLabel
            app.RollAngleLabel = uilabel(app.GridLayout2);
            app.RollAngleLabel.FontName = 'Times New Roman';
            app.RollAngleLabel.Layout.Row = 19;
            app.RollAngleLabel.Layout.Column = 1;
            app.RollAngleLabel.Text = 'Roll Angle';

            % Create RollAngleEditField
            app.RollAngleEditField = uieditfield(app.GridLayout2, 'numeric');
            app.RollAngleEditField.FontName = 'Times New Roman';
            app.RollAngleEditField.Layout.Row = 19;
            app.RollAngleEditField.Layout.Column = 2;
            app.RollAngleEditField.Value = 10;

            % Create HalfLoadEditField_2Label
            app.HalfLoadEditField_2Label = uilabel(app.GridLayout2);
            app.HalfLoadEditField_2Label.BackgroundColor = [0.9412 0.9412 0.9412];
            app.HalfLoadEditField_2Label.FontName = 'Times New Roman';
            app.HalfLoadEditField_2Label.Layout.Row = 2;
            app.HalfLoadEditField_2Label.Layout.Column = 1;
            app.HalfLoadEditField_2Label.Text = 'Half Load';

            % Create HalfLoadEditField_2
            app.HalfLoadEditField_2 = uieditfield(app.GridLayout2, 'numeric');
            app.HalfLoadEditField_2.FontName = 'Times New Roman';
            app.HalfLoadEditField_2.BackgroundColor = [0.9412 0.9412 0.9412];
            app.HalfLoadEditField_2.Layout.Row = 2;
            app.HalfLoadEditField_2.Layout.Column = 2;

            % Create COGinxEditFieldLabel
            app.COGinxEditFieldLabel = uilabel(app.GridLayout2);
            app.COGinxEditFieldLabel.FontName = 'Times New Roman';
            app.COGinxEditFieldLabel.Layout.Row = 3;
            app.COGinxEditFieldLabel.Layout.Column = 1;
            app.COGinxEditFieldLabel.Text = 'COG in x';

            % Create COGinxEditField
            app.COGinxEditField = uieditfield(app.GridLayout2, 'numeric');
            app.COGinxEditField.FontName = 'Times New Roman';
            app.COGinxEditField.Layout.Row = 3;
            app.COGinxEditField.Layout.Column = 2;

            % Create COGHeightEditFieldLabel
            app.COGHeightEditFieldLabel = uilabel(app.GridLayout2);
            app.COGHeightEditFieldLabel.FontName = 'Times New Roman';
            app.COGHeightEditFieldLabel.Layout.Row = 4;
            app.COGHeightEditFieldLabel.Layout.Column = 1;
            app.COGHeightEditFieldLabel.Text = 'COG Height';

            % Create COGHeightEditField
            app.COGHeightEditField = uieditfield(app.GridLayout2, 'numeric');
            app.COGHeightEditField.FontName = 'Times New Roman';
            app.COGHeightEditField.Layout.Row = 4;
            app.COGHeightEditField.Layout.Column = 2;
            app.COGHeightEditField.Value = 530;

            % Create FrontSuspLabel
            app.FrontSuspLabel = uilabel(app.GridLayout2);
            app.FrontSuspLabel.FontName = 'Times New Roman';
            app.FrontSuspLabel.FontSize = 14;
            app.FrontSuspLabel.FontWeight = 'bold';
            app.FrontSuspLabel.Layout.Row = 6;
            app.FrontSuspLabel.Layout.Column = 1;
            app.FrontSuspLabel.Text = 'Front Susp.';

            % Create TrackRearEditFieldLabel
            app.TrackRearEditFieldLabel = uilabel(app.GridLayout2);
            app.TrackRearEditFieldLabel.FontName = 'Times New Roman';
            app.TrackRearEditFieldLabel.Layout.Row = 14;
            app.TrackRearEditFieldLabel.Layout.Column = 1;
            app.TrackRearEditFieldLabel.Text = 'Track Rear';

            % Create TrackRearEditField
            app.TrackRearEditField = uieditfield(app.GridLayout2, 'numeric');
            app.TrackRearEditField.FontName = 'Times New Roman';
            app.TrackRearEditField.Layout.Row = 14;
            app.TrackRearEditField.Layout.Column = 2;
            app.TrackRearEditField.Value = 1530;

            % Create TireEditFieldLabel
            app.TireEditFieldLabel = uilabel(app.GridLayout2);
            app.TireEditFieldLabel.FontName = 'Times New Roman';
            app.TireEditFieldLabel.Layout.Row = 18;
            app.TireEditFieldLabel.Layout.Column = 1;
            app.TireEditFieldLabel.Text = 'Tire';

            % Create TireEditField
            app.TireEditField = uieditfield(app.GridLayout2, 'text');
            app.TireEditField.HorizontalAlignment = 'right';
            app.TireEditField.FontName = 'Times New Roman';
            app.TireEditField.Layout.Row = 18;
            app.TireEditField.Layout.Column = 2;
            app.TireEditField.Value = '20R';

            % Create RearSuspLabel
            app.RearSuspLabel = uilabel(app.GridLayout2);
            app.RearSuspLabel.FontName = 'Times New Roman';
            app.RearSuspLabel.FontSize = 14;
            app.RearSuspLabel.FontWeight = 'bold';
            app.RearSuspLabel.Layout.Row = 13;
            app.RearSuspLabel.Layout.Column = 1;
            app.RearSuspLabel.Text = 'Rear Susp.';

            % Create mmLabel_3
            app.mmLabel_3 = uilabel(app.GridLayout2);
            app.mmLabel_3.HorizontalAlignment = 'center';
            app.mmLabel_3.FontName = 'Times New Roman';
            app.mmLabel_3.Layout.Row = 14;
            app.mmLabel_3.Layout.Column = 3;
            app.mmLabel_3.Text = 'mm';

            % Create KgLabel
            app.KgLabel = uilabel(app.GridLayout2);
            app.KgLabel.HorizontalAlignment = 'center';
            app.KgLabel.FontName = 'Times New Roman';
            app.KgLabel.Layout.Row = 15;
            app.KgLabel.Layout.Column = 3;
            app.KgLabel.Text = 'Kg';

            % Create KgLabel_2
            app.KgLabel_2 = uilabel(app.GridLayout2);
            app.KgLabel_2.HorizontalAlignment = 'center';
            app.KgLabel_2.FontName = 'Times New Roman';
            app.KgLabel_2.Layout.Row = 16;
            app.KgLabel_2.Layout.Column = 3;
            app.KgLabel_2.Text = 'Kg';

            % Create KgLabel_3
            app.KgLabel_3 = uilabel(app.GridLayout2);
            app.KgLabel_3.HorizontalAlignment = 'center';
            app.KgLabel_3.FontName = 'Times New Roman';
            app.KgLabel_3.Layout.Row = 17;
            app.KgLabel_3.Layout.Column = 3;
            app.KgLabel_3.Text = 'Kg';

            % Create Label_2
            app.Label_2 = uilabel(app.GridLayout2);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.FontName = 'Times New Roman';
            app.Label_2.Layout.Row = 19;
            app.Label_2.Layout.Column = 3;
            app.Label_2.Text = '°';

            % Create VehicleLabel
            app.VehicleLabel = uilabel(app.GridLayout2);
            app.VehicleLabel.FontName = 'Times New Roman';
            app.VehicleLabel.FontSize = 14;
            app.VehicleLabel.FontWeight = 'bold';
            app.VehicleLabel.Layout.Row = 1;
            app.VehicleLabel.Layout.Column = 1;
            app.VehicleLabel.Text = 'Vehicle ';

            % Create TrackFrontEditFieldLabel
            app.TrackFrontEditFieldLabel = uilabel(app.GridLayout2);
            app.TrackFrontEditFieldLabel.FontName = 'Times New Roman';
            app.TrackFrontEditFieldLabel.Layout.Row = 7;
            app.TrackFrontEditFieldLabel.Layout.Column = 1;
            app.TrackFrontEditFieldLabel.Text = 'Track Front';

            % Create TrackFrontEditField
            app.TrackFrontEditField = uieditfield(app.GridLayout2, 'numeric');
            app.TrackFrontEditField.Layout.Row = 7;
            app.TrackFrontEditField.Layout.Column = 2;
            app.TrackFrontEditField.Value = 1530;

            % Create HalfLoadEditField_3Label
            app.HalfLoadEditField_3Label = uilabel(app.GridLayout2);
            app.HalfLoadEditField_3Label.FontName = 'Times New Roman';
            app.HalfLoadEditField_3Label.Layout.Row = 8;
            app.HalfLoadEditField_3Label.Layout.Column = 1;
            app.HalfLoadEditField_3Label.Text = 'Half Load';

            % Create HalfLoadEditField_3
            app.HalfLoadEditField_3 = uieditfield(app.GridLayout2, 'numeric');
            app.HalfLoadEditField_3.Layout.Row = 8;
            app.HalfLoadEditField_3.Layout.Column = 2;
            app.HalfLoadEditField_3.Value = 1000;

            % Create MaxLoadEditField_2Label
            app.MaxLoadEditField_2Label = uilabel(app.GridLayout2);
            app.MaxLoadEditField_2Label.FontName = 'Times New Roman';
            app.MaxLoadEditField_2Label.Layout.Row = 9;
            app.MaxLoadEditField_2Label.Layout.Column = 1;
            app.MaxLoadEditField_2Label.Text = 'Max. Load';

            % Create MaxLoadEditField_2
            app.MaxLoadEditField_2 = uieditfield(app.GridLayout2, 'numeric');
            app.MaxLoadEditField_2.Layout.Row = 9;
            app.MaxLoadEditField_2.Layout.Column = 2;
            app.MaxLoadEditField_2.Value = 1250;

            % Create UnsprungEditField_2Label
            app.UnsprungEditField_2Label = uilabel(app.GridLayout2);
            app.UnsprungEditField_2Label.FontName = 'Times New Roman';
            app.UnsprungEditField_2Label.Layout.Row = 10;
            app.UnsprungEditField_2Label.Layout.Column = 1;
            app.UnsprungEditField_2Label.Text = 'Unsprung';

            % Create UnsprungEditField_2
            app.UnsprungEditField_2 = uieditfield(app.GridLayout2, 'numeric');
            app.UnsprungEditField_2.Layout.Row = 10;
            app.UnsprungEditField_2.Layout.Column = 2;
            app.UnsprungEditField_2.Value = 84;

            % Create TireEditField_2Label
            app.TireEditField_2Label = uilabel(app.GridLayout2);
            app.TireEditField_2Label.FontName = 'Times New Roman';
            app.TireEditField_2Label.Layout.Row = 11;
            app.TireEditField_2Label.Layout.Column = 1;
            app.TireEditField_2Label.Text = 'Tire';

            % Create TireEditField_2
            app.TireEditField_2 = uieditfield(app.GridLayout2, 'numeric');
            app.TireEditField_2.Layout.Row = 11;
            app.TireEditField_2.Layout.Column = 2;
            app.TireEditField_2.Value = 19;

            % Create RollAngleEditField_2Label
            app.RollAngleEditField_2Label = uilabel(app.GridLayout2);
            app.RollAngleEditField_2Label.FontName = 'Times New Roman';
            app.RollAngleEditField_2Label.Layout.Row = 12;
            app.RollAngleEditField_2Label.Layout.Column = 1;
            app.RollAngleEditField_2Label.Text = 'Roll Angle';

            % Create RollAngleEditField_2
            app.RollAngleEditField_2 = uieditfield(app.GridLayout2, 'numeric');
            app.RollAngleEditField_2.Layout.Row = 12;
            app.RollAngleEditField_2.Layout.Column = 2;
            app.RollAngleEditField_2.Value = 10;

            % Create mmLabel_4
            app.mmLabel_4 = uilabel(app.GridLayout2);
            app.mmLabel_4.HorizontalAlignment = 'center';
            app.mmLabel_4.FontName = 'Times New Roman';
            app.mmLabel_4.Layout.Row = 7;
            app.mmLabel_4.Layout.Column = 3;
            app.mmLabel_4.Text = 'mm';

            % Create KgLabel_4
            app.KgLabel_4 = uilabel(app.GridLayout2);
            app.KgLabel_4.HorizontalAlignment = 'center';
            app.KgLabel_4.FontName = 'Times New Roman';
            app.KgLabel_4.Layout.Row = 8;
            app.KgLabel_4.Layout.Column = 3;
            app.KgLabel_4.Text = 'Kg';

            % Create KgLabel_5
            app.KgLabel_5 = uilabel(app.GridLayout2);
            app.KgLabel_5.HorizontalAlignment = 'center';
            app.KgLabel_5.FontName = 'Times New Roman';
            app.KgLabel_5.Layout.Row = 9;
            app.KgLabel_5.Layout.Column = 3;
            app.KgLabel_5.Text = 'Kg';

            % Create KgLabel_6
            app.KgLabel_6 = uilabel(app.GridLayout2);
            app.KgLabel_6.HorizontalAlignment = 'center';
            app.KgLabel_6.FontName = 'Times New Roman';
            app.KgLabel_6.Layout.Row = 10;
            app.KgLabel_6.Layout.Column = 3;
            app.KgLabel_6.Text = 'Kg';

            % Create Label_3
            app.Label_3 = uilabel(app.GridLayout2);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.FontName = 'Times New Roman';
            app.Label_3.Layout.Row = 12;
            app.Label_3.Layout.Column = 3;
            app.Label_3.Text = '°';

            % Create KgLabel_7
            app.KgLabel_7 = uilabel(app.GridLayout2);
            app.KgLabel_7.HorizontalAlignment = 'center';
            app.KgLabel_7.FontName = 'Times New Roman';
            app.KgLabel_7.Layout.Row = 2;
            app.KgLabel_7.Layout.Column = 3;
            app.KgLabel_7.Text = 'Kg';

            % Create mmLabel_5
            app.mmLabel_5 = uilabel(app.GridLayout2);
            app.mmLabel_5.HorizontalAlignment = 'center';
            app.mmLabel_5.FontName = 'Times New Roman';
            app.mmLabel_5.Layout.Row = 3;
            app.mmLabel_5.Layout.Column = 3;
            app.mmLabel_5.Text = 'mm';

            % Create mmLabel_6
            app.mmLabel_6 = uilabel(app.GridLayout2);
            app.mmLabel_6.HorizontalAlignment = 'center';
            app.mmLabel_6.FontName = 'Times New Roman';
            app.mmLabel_6.Layout.Row = 4;
            app.mmLabel_6.Layout.Column = 3;
            app.mmLabel_6.Text = 'mm';

            % Create mmLabel_7
            app.mmLabel_7 = uilabel(app.GridLayout2);
            app.mmLabel_7.HorizontalAlignment = 'center';
            app.mmLabel_7.FontName = 'Times New Roman';
            app.mmLabel_7.Layout.Row = 5;
            app.mmLabel_7.Layout.Column = 3;
            app.mmLabel_7.Text = 'mm';

            % Create ExampleDolphinLabel
            app.ExampleDolphinLabel = uilabel(app.GridLayout2);
            app.ExampleDolphinLabel.FontName = 'Times New Roman';
            app.ExampleDolphinLabel.FontSize = 8;
            app.ExampleDolphinLabel.Layout.Row = 1;
            app.ExampleDolphinLabel.Layout.Column = [2 3];
            app.ExampleDolphinLabel.Text = 'Example (Dolphin)';

            % Create ToolsTab
            app.ToolsTab = uitab(app.TabGroup_vehicle);
            app.ToolsTab.Title = 'Tools';

            % Create EditFieldLabel
            app.EditFieldLabel = uilabel(app.ToolsTab);
            app.EditFieldLabel.HorizontalAlignment = 'right';
            app.EditFieldLabel.Position = [10 582 55 22];
            app.EditFieldLabel.Text = 'Edit Field';

            % Create EditField
            app.EditField = uieditfield(app.ToolsTab, 'numeric');
            app.EditField.Position = [80 582 100 22];

            % Create Label_KineBench
            app.Label_KineBench = uilabel(app.UIFigure);
            app.Label_KineBench.BackgroundColor = [0.8 0.8 0.8];
            app.Label_KineBench.FontName = 'Times New Roman';
            app.Label_KineBench.FontSize = 18;
            app.Label_KineBench.Interpreter = 'latex';
            app.Label_KineBench.Position = [0 701 1424 48];
            app.Label_KineBench.Text = '\mathbb{\;\;\;\;KineBench Results Tool\;\;--\;(\beta \;test\;\;-\;macOS\;-\;compatible)\; }';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [15 13 143 21];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'Gestamp_Logo.png');

            % Create beta0304012025Label
            app.beta0304012025Label = uilabel(app.UIFigure);
            app.beta0304012025Label.Interpreter = 'latex';
            app.beta0304012025Label.Position = [156 12 111 22];
            app.beta0304012025Label.Text = '\beta \; -03 \; (04012025)';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = KnC_Bewertung_alpha20250127_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end