# aclk {FREQ_HZ 200000000 CLK_DOMAIN /clk_wiz_0_clk_out1 PHASE 0.0} aclk1 {FREQ_HZ 100000000 CLK_DOMAIN /clk_wiz_0_clk_out1 PHASE 0.0} aclk2 {FREQ_HZ 81247969 CLK_DOMAIN processor_mig_7series_0_2_ui_clk PHASE 0}
# Clock Domain: /clk_wiz_0_clk_out1
create_clock -name aclk -period 5.000 [get_ports aclk]
# Clock Domain: processor_mig_7series_0_2_ui_clk
create_clock -name aclk2 -period 12.308 [get_ports aclk2]
# Generated clocks
create_generated_clock -name aclk1 -source [get_ports aclk] -divide_by 2 [get_ports aclk1]
