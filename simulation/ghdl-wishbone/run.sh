#!/usr/bin/bash

set -e

mkdir -p ./work
cd ./work

echo "analyze eccelerators library"
ghdl -i --std=08 --work=eccelerators ../../../submodules/vhdl-eccelerators-basic-package/src/eccelerators_basic.vhd

echo "analyze testbench devices"
ghdl -i --std=08 ../../../submodules/interrupt-generator/src-gen/vhdl/wishbone/InterruptGeneratorIfcPackage.vhd
ghdl -i --std=08 ../../../submodules/interrupt-generator/src-gen/vhdl/wishbone/InterruptGeneratorIfcWishbone.vhd
ghdl -i --std=08 ../../../submodules/interrupt-generator/src/vhdl/InterruptGenerator.vhd

echo "analyze hxs generated sources"
ghdl -i --std=08 ../../../src-gen/vhdl/wishbone/InterruptCollectorIfcPackage.vhd
ghdl -i --std=08 ../../../src-gen/vhdl/wishbone/InterruptCollectorIfcWishbone.vhd
ghdl -i --std=08 ../../../submodules/bus-divider/src-gen/vhdl/wishbone/BusDividerIfcPackage.vhd
ghdl -i --std=08 ../../../submodules/bus-divider/src-gen/vhdl/wishbone/BusDividerIfcWishbone.vhd
ghdl -i --std=08 ../../../submodules/interrupt-generator/src-gen/vhdl/wishbone/InterruptGeneratorIfcPackage.vhd
ghdl -i --std=08 ../../../submodules/interrupt-generator/src-gen/vhdl/wishbone/InterruptGeneratorIfcWishbone.vhd

echo "analyze ip sources"

echo "analyze sources"

ghdl -i --std=08 ../../../submodules/bus-join/src/vhdl/BusJoinWishbone.vhd
ghdl -i --std=08 ../../../submodules/interrupt-dispatcher/src/vhdl/InterruptDispatcher.vhd
ghdl -i --std=08 ../../../submodules/interrupt-generator/src/vhdl/InterruptGenerator.vhd
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
#./work/tb_top_wishbone --vcd=./trace.vcd --stop-time=100000ns

#echo "show waveforms"
#gtk-wave gtk-waves.gtkw ./trace.vcd

#docker run -it -v ${PWD}:/work -w /work ghdl/ghdl:ubuntu22-llvm-11