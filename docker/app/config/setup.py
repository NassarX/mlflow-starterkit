# Lint as: python3
# pylint: enable=line-too-long
from setuptools import find_packages, setup

long_description = "Package Description From README.md"

QUALITY_REQUIRE = [
    "black~=22.0",
    "isort==5.8.0",
    "flake8==3.9.2",
    "mypy==0.901",
]

TEST_REQUIRE = ["pytest", "pytest-cov"]

EXTRAS_REQUIRE = {
    "dev": QUALITY_REQUIRE,
    "quality": QUALITY_REQUIRE,
    "test": TEST_REQUIRE,
    "docs": [
    ],
}

with open("requirements.txt") as f:
    INSTALL_REQUIRES = f.read().splitlines()

setup(
    name="starterkit",
    description="Starterkit",
    long_description="Just a starterkit for my own projects",
    long_description_content_type="text/markdown",
    author="Mahmoud Nassar",
    url="https://github.com/nassarx",
    packages=find_packages("."),
    entry_points={"console_scripts": []},  # @TODO add console scripts
    install_requires=INSTALL_REQUIRES,
    extras_require=EXTRAS_REQUIRE,
    python_requires=">=3.9",
    classifiers=[
        "Intended Audience :: Developers",
        "Intended Audience :: Education",
        "Intended Audience :: Science/Research",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3.10",
        "Topic :: Scientific/Engineering :: Artificial Intelligence",
    ],
    keywords="Machine-Learning Deep-Learning NLP PyTorch TensorFlow AI",
    include_package_data=True,
)
