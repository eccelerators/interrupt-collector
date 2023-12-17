#!/usr/bin/bash

set -e

mkdir -p ./work
cd ./work

echo "analyze testbench devices"

echo "analyze hxs generated sources"
ghdl -i --std=08 ../../../src-gen/vhdl/wishbone/InterruptCollectorIfcPackage.vhd
ghdl -i --std=08 ../../../src-gen/vhdl/wishbone/InterruptCollectorIfcWishbone.vhd

echo "analyze ip sources"

echo "analyze sources"
ghdl -i --std=08 ../../../src/vhdl/InterruptCollector.vhd

echo "analyze testbench"
ghdl -i --std=08 ../../../submodules/simstm/src/tb_base_pkg.vhd
ghdl -i --std=08 ../../../submodules/simstm/src/tb_base_pkg_body.vhd
ghdl -i --std=08 ../../../submodules/simstm/src/tb_instructions_pkg.vhd
ghdl -i --std=08 ../../../submodules/simstm/src/tb_interpreter_pkg.vhd
ghdl -i --std=08 ../../../submodules/simstm/src/tb_interpreter_pkg_body.vhd
ghdl -i --std=08 ../../../submodules/simstm/src/tb_bus_avalon_pkg.vhd
ghdl -i --std=08 ../../../submodules/simstm/src/tb_bus_axi4lite_pkg.vhd
ghdl -i --std=08 ../../../submodules/simstm/src/tb_bus_wishbone_pkg.vhd
ghdl -i --std=08 ../../../submodules/simstm/src_to_customize/tb_bus_pkg.vhd
ghdl -i --std=08 ../../../tb/hdl/tb_signals_pkg.vhd
ghdl -i --std=08 ../../../submodules/simstm/src/tb_simstm.vhd

echo "analyze toplevel"
ghdl -i --std=08 ../../../tb/hdl/tb_top_wishbone.vhd

echo "elaborate"
ghdl -m --std=08 tb_top_wishbone 

cd ..

echo "start simulation"
./work/tb_top_wishbone --stop-time=10000000ns