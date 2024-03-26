import setuptools

with open("CHANGELOG.md", "r") as fh:
    long_description = fh.read()

__tag__ = ""
__build__ = 0
__commit__ = "0000000"
__version__ = "{}".format(__tag__)

# Section is used to generate an AMD project file
# Dont't use trailing ,
# Only use " but '
# start static_setup_data section
static_setup_data = {
    "name" : "interrupt-collector", 
    "author": "Heinrich Diebel, Bernd Roeckert, Denis Vasilik",
    "author_email" : "heinrich.diebel@emerson.com; bernd.roeckert@emerson.com; denis.vasilik@emerson.com;",
    "url" : "https://gitlab.aug/fpga/interrupt-collector/",
    "description" : "InterruptCollector",
    "long_description_content_type" : "text/markdown",                   
    "classifiers" : [
        "Programming Language :: Python :: 3.7",
        "Operating System :: OS Independent"
    ],
    "dependency_links" : [],
    "package_data" : {}, 
    "project_name" : "InterruptCollector",
    "top_entity" : "InterruptCollector",
    "top_entity_file" : "src/vhdl/InterruptCollector.vhd",
    "tb_top_entity" : "tb_top_wishbone",
    "tb_top_entity_file" : "/tb/hdl/tb_top_wishbone.vhd",
    "test_suites" : [
    ],
    "test_labs" : [
    ],
    "other_data_files" : [(
        "interrupt-collector/resources", [
            {"file":"src-gen/c/InterruptCollectorIfc.h"},
            {"file":"src-gen/simstm/InterruptCollectorIfc.stm"},
            {"file":"src-gen/python/InterruptCollectorIfcPlain.py"},
            {"file":"src-gen/docbook-pdf/emerson.pac.InterruptCollectorIfc.pdf"}
        ]),(
        "interrupt-collector/package/xgui", [
            {"file":"package/xgui/InterruptCollector_v1_0.tcl"}
        ]),(
        "interrupt-collector", [
            {"file":"CHANGELOG.md"},
            {"file":"README.rst"}
        ])
    ],
    "src_data_files" : [(
        "interrupt-collector/package", [
            {"file":"package/component.xml", "file_type":"IP-XACT"}
        ]),(
        "interrupt-collector/submodules/vhdl-eccelerators-basic-package/src", [
            {"file":"submodules/vhdl-eccelerators-basic-package/src/eccelerators_basic.vhd", "file_type":"VHDL 2008", "hdl_order":"00050"}
        ]),(
        "interrupt-collector/src-gen/vhdl", [
            {"file":"src-gen/vhdl/InterruptCollectorIfcPackage.vhd", "file_type":"VHDL 2008", "hdl_order":"00170"},
            {"file":"src-gen/vhdl/InterruptCollectorIfcWishbone.vhd", "file_type":"VHDL 2008", "hdl_order":"00190"}
        ]),(
        "interrupt-collector/src/vhdl", [
            {"file":"src/vhdl/InterruptCollector.vhd", "file_type":"VHDL 2008", "hdl_order":"00180"}
        ])
    ],
    "tb_data_files" : [(
        "interrupt-collector/submodules/bus-divider/src-gen/vhdl/wishbone", [
            {"file":"submodules/bus-divider/src-gen/vhdl/wishbone/BusDividerIfcWishbone.vhd", "file_type":"VHDL 2008", "hdl_order":"00160", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/bus-divider/src-gen/vhdl/wishbone/BusDividerIfcPackage.vhd", "file_type":"VHDL 2008", "hdl_order":"00150", "ghdl_options":["-frelaxed"]}
        ]),(
        "interrupt-collector/submodules/bus-join/src/vhdl", [
            {"file":"submodules/bus-join/src/vhdl/BusJoinWishbone.vhd", "file_type":"VHDL 2008", "hdl_order":"00140", "ghdl_options":["-frelaxed"]}
        ]),(
        "interrupt-collector/submodules/interrupt-dispatcher/src/vhdl", [
            {"file":"submodules/interrupt-dispatcher/src/vhdl/InterruptDispatcher.vhd", "file_type":"VHDL 2008", "hdl_order":"00130", "ghdl_options":["-frelaxed"]}
        ]),(
        "interrupt-collector/submodules/interrupt-generator/src-gen/vhdl/wishbone", [
            {"file":"submodules/interrupt-generator/src-gen/vhdl/wishbone/InterruptGeneratorIfcWishbone.vhd", "file_type":"VHDL 2008", "hdl_order":"00120", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/interrupt-generator/src-gen/vhdl/wishbone/InterruptGeneratorIfcPackage.vhd", "file_type":"VHDL 2008", "hdl_order":"00100", "ghdl_options":["-frelaxed"]}
        ]),(
        "interrupt-collector/submodules/interrupt-generator/src/vhdl", [
            {"file":"submodules/interrupt-generator/src/vhdl/InterruptGenerator.vhd", "file_type":"VHDL 2008", "hdl_order":"00110", "ghdl_options":["-frelaxed"]}
        ]),(
        "interrupt-collector/submodules/simstm/src", [
            {"file":"submodules/simstm/src/tb_bus_axi4lite_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00020", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_interpreter_pkg_body.vhd", "file_type":"VHDL 2008", "hdl_order":"00081", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_base_pkg_body.vhd", "file_type":"VHDL 2008", "hdl_order":"00061", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_instructions_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00070", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_bus_wishbone_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00010", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_base_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00060", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_bus_avalon_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00030", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_interpreter_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00080", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_simstm.vhd", "file_type":"VHDL 2008", "hdl_order":"00090", "ghdl_options":["-frelaxed"]}
        ]),(
        "interrupt-collector/tb/hdl/simstm_src_to_customize", [
            {"file":"tb/hdl/simstm_src_to_customize/tb_signals_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00000", "ghdl_options":["-frelaxed"]},
            {"file":"tb/hdl/simstm_src_to_customize/tb_bus_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00040", "ghdl_options":["-frelaxed"]}
        ]),(
        "interrupt-collector/tb/hdl", [
            {"file":"tb/hdl/tb_top_wishbone.vhd", "file_type":"VHDL 2008", "hdl_order":"00200", "ghdl_options":["-frelaxed"]}
        ])
    ],
    "src_tb_simstm_data_files" : [(
        "interrupt-collector/src-gen/simstm", [
            {"file":"src-gen/simstm/InterruptCollectorIfc.stm"}
        ]),(
        "interrupt-collector/tb/simstm/Base", [
            {"file":"tb/simstm/Base/Base.stm"},
            {"file":"tb/simstm/Base/ReadModifyWrite.stm"},
            {"file":"tb/simstm/Base/Array.stm"}
        ]),(
        "interrupt-collector/tb/simstm", [
            {"file":"tb/simstm/testMain.stm"}
        ])
    ],
      
    "setup_requires" : []
}
# end static_setup_data section

setup_data_files = []
setup_data_files_sections = ["other_data_files", "src_data_files", "tb_data_files", "src_tb_simstm_data_files"]

for section in setup_data_files_sections: 
    for data_folder_file_list_pair in static_setup_data[section]:
        data_folder_file_list = []
        for data_file_dict in data_folder_file_list_pair[1]:
            data_folder_file_list.append(data_file_dict["file"])
        setup_data_files.append((data_folder_file_list_pair[0], data_folder_file_list))

setuptools.setup(
    name = static_setup_data["name"],
    version = __version__,
    author = static_setup_data["author"],
    author_email = static_setup_data["author_email"],
    url = static_setup_data["url"],
    description = static_setup_data["description"],
    long_description = long_description,
    long_description_content_type = static_setup_data["long_description_content_type"],
    packages = setuptools.find_packages(),
    classifiers= static_setup_data["classifiers"],
    dependency_links = static_setup_data["dependency_links"],
    package_data = static_setup_data["package_data"],
    data_files = setup_data_files,
    setup_requires = static_setup_data["setup_requires"]
)