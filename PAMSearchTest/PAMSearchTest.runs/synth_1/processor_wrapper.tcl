# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/SeniorDesign2/PAMSearchTest/PAMSearchTest.cache/wt [current_project]
set_property parent.project_path D:/SeniorDesign2/PAMSearchTest/PAMSearchTest.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property ip_repo_paths {
  d:/SeniorDesign2/ip_repo/DNA_Search_SmallScale_Debug_1.0
  d:/SeniorDesign2/ip_repo
  c:/Users/peter/Documents/vivado-library-master
} [current_project]
set_property ip_output_repo d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib D:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/hdl/processor_wrapper.v
add_files D:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/processor.bd
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_clk_wiz_0_0/processor_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_clk_wiz_0_0/processor_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_clk_wiz_0_0/processor_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_uartlite_0_0/processor_axi_uartlite_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_uartlite_0_0/processor_axi_uartlite_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_uartlite_0_0/processor_axi_uartlite_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_gpio_0_0/processor_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_gpio_0_0/processor_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_gpio_0_0/processor_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_microblaze_0_2/processor_microblaze_0_2.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_microblaze_0_2/processor_microblaze_0_2_ooc_debug.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_microblaze_0_2/processor_microblaze_0_2_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_mdm_1_2/processor_mdm_1_2.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_mdm_1_2/processor_mdm_1_2_ooc_trace.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_rst_clk_wiz_0_100M_2/processor_rst_clk_wiz_0_100M_2_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_rst_clk_wiz_0_100M_2/processor_rst_clk_wiz_0_100M_2.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_rst_clk_wiz_0_100M_2/processor_rst_clk_wiz_0_100M_2_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_mig_7series_0_2/processor_mig_7series_0_2/user_design/constraints/processor_mig_7series_0_2.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_mig_7series_0_2/processor_mig_7series_0_2/user_design/constraints/processor_mig_7series_0_2_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_mig_7series_0_2/processor_mig_7series_0_2_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_13/bd_4f79_s00a2s_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_22/bd_4f79_s01a2s_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_25/bd_4f79_m00s2a_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_26/bd_4f79_m00arn_0/bd_4f79_m00arn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_26/bd_4f79_m00arn_0/bd_4f79_m00arn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_26/bd_4f79_m00arn_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_27/bd_4f79_m00rn_0/bd_4f79_m00rn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_27/bd_4f79_m00rn_0/bd_4f79_m00rn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_27/bd_4f79_m00rn_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_28/bd_4f79_m00awn_0/bd_4f79_m00awn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_28/bd_4f79_m00awn_0/bd_4f79_m00awn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_28/bd_4f79_m00awn_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_29/bd_4f79_m00wn_0/bd_4f79_m00wn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_29/bd_4f79_m00wn_0/bd_4f79_m00wn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_29/bd_4f79_m00wn_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_30/bd_4f79_m00bn_0/bd_4f79_m00bn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_30/bd_4f79_m00bn_0/bd_4f79_m00bn_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_30/bd_4f79_m00bn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_23/bd_4f79_sarn_1_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_24/bd_4f79_srn_1_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_14/bd_4f79_sarn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_15/bd_4f79_srn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_16/bd_4f79_sawn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_17/bd_4f79_swn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_18/bd_4f79_sbn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_5/bd_4f79_arsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_6/bd_4f79_rsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_7/bd_4f79_awsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_8/bd_4f79_wsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_9/bd_4f79_bsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_1/bd_4f79_psr0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_1/bd_4f79_psr0_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_2/bd_4f79_psr_aclk_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_2/bd_4f79_psr_aclk_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_3/bd_4f79_psr_aclk1_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_3/bd_4f79_psr_aclk1_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_4/bd_4f79_psr_aclk2_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/bd_0/ip/ip_4/bd_4f79_psr_aclk2_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_axi_smc_0/ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_rst_mig_7series_0_81M_0/processor_rst_mig_7series_0_81M_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_rst_mig_7series_0_81M_0/processor_rst_mig_7series_0_81M_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_rst_mig_7series_0_81M_0/processor_rst_mig_7series_0_81M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_axi_gpio_0_0/PmodSD_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_axi_gpio_0_0/PmodSD_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_axi_gpio_0_0/PmodSD_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_axi_quad_spi_0_0/PmodSD_axi_quad_spi_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_axi_quad_spi_0_0/PmodSD_axi_quad_spi_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_axi_quad_spi_0_0/PmodSD_axi_quad_spi_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_axi_quad_spi_0_0/PmodSD_axi_quad_spi_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_pmod_bridge_0_0/PmodSD_pmod_bridge_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_pmod_bridge_0_0/src/pmod_concat_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/processor_PmodSD_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_PmodSD_0_0/src/PmodSD_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_xbar_0/processor_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_dlmb_v10_2/processor_dlmb_v10_2.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_dlmb_v10_2/processor_dlmb_v10_2_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_ilmb_v10_2/processor_ilmb_v10_2.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_ilmb_v10_2/processor_ilmb_v10_2_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_dlmb_bram_if_cntlr_2/processor_dlmb_bram_if_cntlr_2_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_ilmb_bram_if_cntlr_2/processor_ilmb_bram_if_cntlr_2_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/ip/processor_lmb_bram_2/processor_lmb_bram_2_ooc.xdc]
set_property used_in_implementation false [get_files -all D:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/processor_ooc.xdc]
set_property is_locked true [get_files D:/SeniorDesign2/PAMSearchTest/PAMSearchTest.srcs/sources_1/bd/processor/processor.bd]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top processor_wrapper -part xc7a100tcsg324-1


write_checkpoint -force -noxdef processor_wrapper.dcp

catch { report_utilization -file processor_wrapper_utilization_synth.rpt -pb processor_wrapper_utilization_synth.pb }