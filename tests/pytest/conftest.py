import pytest

def pytest_addoption(parser):
    parser.addoption("--cluster", default="127.0.0.1")


def pytest_generate_tests(metafunc):
    # This is called for every test. Only get/set command line arguments
    # if the argument is specified in the list of test "fixturenames".
    option_values = metafunc.config.option
    if 'cluster' in metafunc.fixturenames and option_values.cluster is not None:
        metafunc.parametrize("cluster", [option_values.cluster])
