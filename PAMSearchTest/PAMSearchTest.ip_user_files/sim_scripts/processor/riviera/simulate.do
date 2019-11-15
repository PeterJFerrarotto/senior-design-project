onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+processor -L xil_defaultlib -L xpm -L axi_lite_ipif_v3_0_4 -L lib_pkg_v1_0_2 -L lib_srl_fifo_v1_0_2 -L lib_cdc_v1_0_2 -L axi_uartlite_v2_0_17 -L interrupt_control_v3_1_4 -L axi_gpio_v2_0_15 -L microblaze_v10_0_3 -L mdm_v3_2_10 -L proc_sys_reset_v5_0_11 -L smartconnect_v1_0 -L xlconstant_v1_1_3 -L dist_mem_gen_v8_0_11 -L fifo_generator_v13_1_4 -L lib_fifo_v1_0_8 -L axi_quad_spi_v3_2_12 -L generic_baseblocks_v2_1_0 -L axi_infrastructure_v1_1_0 -L axi_register_slice_v2_1_13 -L axi_data_fifo_v2_1_12 -L axi_crossbar_v2_1_14 -L lmb_v10_v3_0_9 -L lmb_bram_if_cntlr_v4_0_12 -L blk_mem_gen_v8_3_6 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.processor xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {processor.udo}

run -all

endsim

quit -force
