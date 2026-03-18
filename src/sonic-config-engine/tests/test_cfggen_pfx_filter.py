import os
import subprocess

import tests.common_utils as utils

from unittest import TestCase


class TestPfxFilter(TestCase):
    def test_comprehensive(self):
        # Generate output
        data_dir = "tests/data/pfx_filter"
        output_file = "/tmp/result_1_{}.txt".format(os.getpid())
        cmd = [utils.PYTHON_INTERPRETTER, "./sonic-cfggen", "-j", "{}/param_1.json".format(data_dir), "-t", "{}/tmpl_1.txt.j2".format(data_dir)]
        output = subprocess.check_output(cmd, universal_newlines=True)
        with open(output_file, 'w') as f:
            f.write(output)
        # Compare outputs
        cmd = ["diff", "-u", "tests/data/pfx_filter/result_1.txt", output_file]
        try:
            res = subprocess.check_output(cmd)
        except subprocess.CalledProcessError as e:
            assert False, "Wrong output. return code: %d, Diff: %s" % (e.returncode, e.output)
