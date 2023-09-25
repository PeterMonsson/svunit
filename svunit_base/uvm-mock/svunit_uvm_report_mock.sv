//###########################################################################
//
//  Copyright 2011 The SVUnit Authors.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//###########################################################################

class uvm_report_mock;
  static svunit_uvm_report_mock_expected_actual_container reports = null;

  static function svunit_uvm_report_mock_expected_actual_container get_reports();
     if (reports == null) begin
	reports = new();
     end
     return reports;
  endfunction

   
  static function void setup();
    svunit_uvm_report_mock_expected_actual_container reports = get_reports();
    reports.delete();
  endfunction

  static function int expected_cnt();
    svunit_uvm_report_mock_expected_actual_container reports = get_reports();
    return reports.expected.size();
  endfunction

  static function int actual_cnt();
    svunit_uvm_report_mock_expected_actual_container reports = get_reports();
    return reports.actual.size();
  endfunction

  `define EXPECT_SEVERITY(NAME, SEV) \
    static function void expect_``NAME(string id="", \
                                       string message=""); \
      svunit_uvm_report_mock_expected_actual_container reports = get_reports(); \
      reports.expected.push_back('{id, message, SEV}); \
    endfunction

  `EXPECT_SEVERITY(warning, UVM_WARNING)
  `EXPECT_SEVERITY(error,   UVM_ERROR)
  `EXPECT_SEVERITY(fatal,   UVM_FATAL)

  static function bit verify_complete();
    svunit_uvm_report_mock_expected_actual_container reports = get_reports();
    return reports.verify_complete();
  endfunction

  static function string dump();
    svunit_uvm_report_mock_expected_actual_container reports = get_reports();
    return reports.dump();
  endfunction
endclass
