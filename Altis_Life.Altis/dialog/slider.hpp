class SliderMenu {
    idd = 2919;
    name = "SliderMenu";
    movingEnable = 1;
    enableSimulation = 1;

    class controlsBackground {
        class Life_RscTitleBackground: Life_RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            text = "Select Amount";
            x = 0.371034 * safezoneW + safezoneX;
          	y = 0.423032 * safezoneH + safezoneY;
            w = 0.257932 * safezoneW;
            h = (1 / 25);
        };

        class MainBackground: Life_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.371033 * safezoneW + safezoneX;
          	y = (0.445022 * safezoneH + safezoneY) + 0.005;
      	    w = 0.257932 * safezoneW;
            h = 0.10;
        };
    };

    class controls {
      class Slider_bar: life_RscXSliderH {
          idc = 2901;
          text = "";
          tooltip = "";
          x = 0.371033 * safezoneW + safezoneX + 0.005;
          y = (0.445022 * safezoneH + safezoneY) + 0.04 + 0.015;
          w = (0.257932 * safezoneW) - 0.010;
          h = "1 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          onSliderPosChanged = "ctrlSetText [2902, str (round (sliderPosition 2901))];"
      };

      class Slider_value: Life_RscEdit {
          idc = 2902;
          style = 2;
          text = "0";
          x = (0.371033 * safezoneW + safezoneX) + ((0.257932 * safezoneW) / 2) - 0.04;
          y = (0.445022 * safezoneH + safezoneY) + 0.010;
          w = .10;
          h = .04;
      };

      class CloseButtonKey: Life_RscButtonMenu {
          idc = -1;
          text = "Close";
          onButtonClick = "closeDialog 0;";
          
          x = 0.371033 * safezoneW + safezoneX;
          y = (0.445022 * safezoneH + safezoneY) + 0.010 + 0.10;
          w = (6.25 / 40);
          h = (1 / 25);

          class Attributes
          {
           align = "center";
          };
      };

      class ConfirmButtonKey: Life_RscButtonMenu {
          idc = 2903;
          text = "Select";

          x = 0.371033 * safezoneW + safezoneX + (0.257932 * safezoneW) - (6.25 / 40);
          y = (0.445022 * safezoneH + safezoneY) + 0.010 + 0.10;
          w = (6.25 / 40);
          h = (1 / 25);

          class Attributes
          {
           align = "center";
          };
      };
    };
};
