from setuptools import setup, find_packages

setup(
    name='aaqa',
    version='0.9',
    description='Automated Annual QA is a set of scripts aimed to eliminate the repetitive manual labour and to improve the reproducibility of the Quality Control data analysis for MRI scanners',
    author='Patxi Torrealdea ',
    author_email='francisco.torrealdea@nhs.net',
    url='https://github.com/papomail/Annual_QA_pipeline',
    packages=find_packages(),

    install_requires=[
        "easygui_qt",
		"pathlib",
		"pydicom",
		"pandas",
		"openpyxl",
    ],
    setup_requires=['pytest-runner', 'flake8'],
    tests_require=['pytest'],
    package_dir={'scripts'},
    package_data={
        'scripts.MagNET_QA_scripts':['*'],
 
    },
    include_package_data=True,
    entry_points={
        'console_scripts': ['aaqa=scripts.automated_AQA:main']
    }    

)


