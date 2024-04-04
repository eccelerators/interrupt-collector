import os
from json import loads
from pathlib import Path, PurePath
from setup_data_to_json import SetupToJson

import click

class PlausibilityCheckOfSetupPy:
    
    def generate(self, setup_py_file_path, project_dir_path):
        
        project_folder_path = os.path.abspath(project_dir_path)       
        project_folder_name = PurePath(project_folder_path).name
        project_name = self.project_folder_name_to_project_name(project_folder_name)
        
        extractor = SetupToJson()
        file_path = open(setup_py_file_path, 'r')     
        print("reading {}".format(setup_py_file_path))
        json_string = extractor.extract(setup_py_file_path)
        static_setup_data = loads(json_string)
        
        TestSuiteFileDictList = []
        if os.path.isdir(project_folder_path + '/tb/simstm/TestSuites'):
            for f in os.listdir(project_folder_path + '/tb/simstm/TestSuites'):
                if os.path.isfile(project_folder_path + '/tb/simstm/TestSuites' + '/' + f):
                    if Path(project_folder_path + '/tb/simstm/TestSuites' + '/' + f).suffix in ['.stm']:                   
                        if "TestSuite" in f:  
                            TestSuiteObjectName = Path(project_folder_path + '/tb/simstm/TestSuites' + '/' + f).stem[9:]   
                            if TestSuiteObjectName.startswith("Indexed"):
                                isIndexedTestSuite = True
                            else:
                                isIndexedTestSuite = False                         
                            tsf = open(project_folder_path + '/tb/simstm/TestSuites' + '/' + f, 'r')
                            tsf_lines = tsf.readlines()
                            for l in tsf_lines:
                                if l.startswith("testSuite"):
                                    testsuite_name = l.split(':')[0]
                                    break
                            entry_file = "testMainSuite"  + TestSuiteObjectName + ".stm"
                            entry_label = "$testMainSuite" + TestSuiteObjectName  
                        if isIndexedTestSuite:  
                            tsmf = open(project_folder_path+ '/tb/simstm/' + entry_file, 'r')
                            tsmf_lines = tsmf.readlines()
                            for l in tsmf_lines:
                                if "const" in l and "testMainSuite"  + TestSuiteObjectName + "MaximumIndex" in l:
                                    testsuite_indexes = l.split()[2]
                                    break                                                                            
                            TestSuiteFileDictList.append({"testsuite-name": testsuite_name, 
                                                      "file":"TestSuites/" + f,
                                                      "testsuite-indexes": "10",                                                   
                                                      "entry-file":entry_file, 
                                                      "entry-label":entry_label})
                        else:
                            TestSuiteFileDictList.append({"testsuite-name": testsuite_name, 
                                                      "file":"TestSuites/" + f,                                                
                                                      "entry-file":entry_file, 
                                                      "entry-label":entry_label})        
                        
                        
        for test_suite_defined in static_setup_data["test_suites"]:
            test_suite_found = False  
            for test_suite_expected in TestSuiteFileDictList:
                if test_suite_expected["testsuite-name"] == test_suite_defined["testsuite-name"]:
                    test_suite_found = True 
                    if test_suite_expected["file"] != test_suite_defined["file"]:
                        print("file expected" + test_suite_expected["file"] + "but got" + test_suite_defined["file"])
                    if "testsuite-indexes" in test_suite_expected:
                        if test_suite_expected["testsuite-indexes"] != test_suite_defined["testsuite-indexes"]:
                            print("testsuite-indexes expected" + test_suite_expected["testsuite-indexes"] + "but got" + test_suite_defined["testsuite-indexes"])
                    else:
                        if "testsuite-indexes" in test_suite_defined:
                             print("testsuite-indexes not expected at all expected")
                        
                    if test_suite_expected["entry-file"] != test_suite_defined["entry-file"]:
                        print("entry-file expected" + test_suite_expected["entry-file"] + "but got" + test_suite_defined["entry-file"])
                    if test_suite_expected["entry-label"] != test_suite_defined["entry-label"]:
                        print("entry-label expected" + test_suite_expected["entry-label"] + "but got" + test_suite_defined["entry-label"])
            if not test_suite_found:
               print("testsuite expected " + test_suite_expected["testsuite-name"] +" not found")                    
        
        for other_data_file_per_dest in static_setup_data["other_data_files"]:                    
            for other_data_file in other_data_file_per_dest[1]:
                if not os.path.isfile(project_dir_path + '/' + other_data_file["file"]):                   
                    print(project_dir_path + '/' + other_data_file["file"] + " doesn't exist !")
                else:
                    p = Path(os.path.abspath(project_dir_path + '/' + other_data_file["file"]))
                    if not self.path_exists_case_sensitive(p): 
                        print(project_dir_path + '/' + other_data_file["file"] + " differs in case !")
        
        for src_data_file_per_dest in static_setup_data["src_data_files"]:                    
            for src_data_file in src_data_file_per_dest[1]:
                if not os.path.isfile(project_dir_path + '/' + src_data_file["file"]):                   
                    print(project_dir_path + '/' + src_data_file["file"] + " doesn't exist !")
                else:
                    p = Path(os.path.abspath(project_dir_path + '/' + src_data_file["file"]))
                    if not self.path_exists_case_sensitive(p): 
                        print(project_dir_path + '/' + src_data_file["file"] + " differs in case !")

        for tb_data_file_per_dest in static_setup_data["tb_data_files"]:                       
            for tb_data_file in tb_data_file_per_dest[1]:
                if not os.path.isfile(project_dir_path + '/' + tb_data_file["file"]):                   
                    print(project_dir_path + '/' + tb_data_file["file"] + " doesn't exist !")
                else:
                    p = Path(os.path.abspath(project_dir_path + '/' + tb_data_file["file"]))
                    if not self.path_exists_case_sensitive(p): 
                        print(project_dir_path + '/' + tb_data_file["file"] + " differs in case !")

        for src_tb_simstm_data_file_per_dest in static_setup_data["src_tb_simstm_data_files"]:                       
            for src_tb_simstm_data_file in src_tb_simstm_data_file_per_dest[1]:
                if not os.path.isfile(project_dir_path + '/' + src_tb_simstm_data_file["file"]):                   
                    print(project_dir_path + '/' + src_tb_simstm_data_file["file"] + " doesn't exist !")
                else:
                    p = Path(os.path.abspath(project_dir_path + '/' + src_tb_simstm_data_file["file"]))
                    if not self.path_exists_case_sensitive(p): 
                        print(project_dir_path + '/' + src_tb_simstm_data_file["file"] + " differs in case !")
                        
       
        if static_setup_data["project_name"] != project_name:
            print("Expected project_name {} but got {}".format(project_name, static_setup_data["project_name"]))

        if not os.path.isfile(project_dir_path + '/' + static_setup_data["top_entity_file"]):                   
            print("top_entity file" + project_dir_path + '/' + static_setup_data["top_entity_file"] + " doesn't exist !")
        else:
            p = Path(os.path.abspath(project_dir_path + '/' + static_setup_data["top_entity_file"]))
            if not self.path_exists_case_sensitive(p): 
                print("top_entity file" + project_dir_path + '/' + static_setup_data["top_entity_file"] + " differs in case !")            

        if not os.path.isfile(project_dir_path + '/' + static_setup_data["tb_top_entity_file"]):                   
            print("tb top_entity file" + project_dir_path + '/' + static_setup_data["tb_top_entity_file"] + " doesn't exist !")
        else:
            p = Path(os.path.abspath(project_dir_path + '/' + static_setup_data["tb_top_entity_file"]))
            if not self.path_exists_case_sensitive(p): 
                print("tb top_entity file" + project_dir_path + '/' + static_setup_data["tb_top_entity_file"] + " differs in case !")            

        f = open(project_folder_path + '/' + static_setup_data["top_entity_file"], 'r')
        f_lines = f.readlines()
        for l in f_lines:
            if "entity" in l:
                top_entity = l.split()[1]
                break
        
        if static_setup_data["top_entity"] != top_entity:   
            print("Expected top_entity {} but got {}".format(project_name, static_setup_data["top_entity"]))
        
        f = open(project_folder_path + '/' + static_setup_data["tb_top_entity_file"], 'r')
        f_lines = f.readlines()
        for l in f_lines:
            if "entity" in l:
                tb_top_entity = l.split()[1]
                break
            
        if static_setup_data["tb_top_entity"] != tb_top_entity:   
            print("Expected tb_top_entity {} but got {}".format(project_name, static_setup_data["tb_top_entity"]))
            
        print("Check done")
        
        
    def project_folder_name_to_project_name(self, project_folder_name):
        project_name = ""
        project_folder_name_parts = project_folder_name.split('-')
        for p in project_folder_name_parts:
            project_name += p[0].upper() + p[1:]
        return project_name    
    
    def path_exists_case_sensitive(self, p: Path) -> bool:
        """Check if path exists, enforce case sensitivity.
    
        Arguments:
          p: Path to check
        Returns:
          Boolean indicating if the path exists or not
        """
        # If it doesn't exist initially, return False
        if not p.exists():
            return False
    
        # Else loop over the path, checking each consecutive folder for
        # case sensitivity
        while True:
            # At root, p == p.parent --> break loop and return True
            if p == p.parent:
                return True
            # If string representation of path is not in parent directory, return False
            if str(p) not in map(str, p.parent.iterdir()):
                return False
            p = p.parent 
        
@click.command()
@click.option('--infile', default='../setup.py',  help='path to setup.py to check')
@click.option('--indir_project', default='..',  help='path project folder to check')
def generate(infile, indir_project):
    obj = PlausibilityCheckOfSetupPy()
    obj. generate(setup_py_file_path=infile, project_dir_path=indir_project)

if __name__ == '__main__':
    generate()