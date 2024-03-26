from git import Repo, Submodule

repo = Repo('.')

submodule_list = [
    [ "ci", "ci", "https://gitlab.emrsn.org/fpga/ip_ci_xilinx.git" ],
    # [ "break_docbook_program_listing", "submodules/break_docbook_program_listing", "https://gitlab.emrsn.org/tools/break_docbook_program_listing.git" ],
    # [ "sphinx_template", "submodules/sphinx_template", "https://gitlab.emrsn.org/tools/sphinx_template.git" ],
    # [ "sphinx_docbook", "submodules/sphinx_docbook", "https://gitlab.emrsn.org/tools/sphinx_docbook.git" ],
    # [ "pacusc_docbook", "submodules/pacusc_docbook", "https://gitlab.emrsn.org/tools/pacusc_docbook.git" ],
    # [ "tmp_hxs_gen", "submodules/tmp_hxs_gen", "https://gitlab.emrsn.org/fpga/tmp_hxs_gen.git" ],
    # [ "setup2vivado", "submodules/setup2vivado", "https://gitlab.emrsn.org/tools/setup2vivado.git" ],
    # [ "pacusc_basic", "submodules/pacusc_basic", "https://gitlab.emrsn.org/fpga/pacusc_basic.git" ],
    # [ "pacusc_ant_builds", "submodules/pacusc_ant_builds", "https://gitlab.emrsn.org/fpga/pacusc_ant_builds.git" ],
    # [ "vhdl-eccelerators-basic-package", "submodules/vhdl-eccelerators-basic-package", "https://github.com/eccelerators/vhdl-eccelerators-basic-package.git" ],
    # [ "usual-objects", "submodules/usual-objects", "https://github.com/eccelerators/usual-objects.git" ],
    # [ "collect_fpga_build_results", "submodules/collect_fpga_build_results", "https://gitlab.emrsn.org/tools/collect_fpga_build_results.git"],
    # [ "simstm", "submodules/simstm", "https://github.com/eccelerators/simstm.git" ],
    # [ "setup2modelsim", "submodules/setup2modelsim", "https://gitlab.emrsn.org/tools/setup2modelsim.git" ],
    # [ "setup2ghdl", "submodules/setup2ghdl", "https://gitlab.emrsn.org/tools/setup2ghdl.git" ],
]


for m in submodule_list:
    Submodule.add(repo, m[0], m[1], m[2])
    
    