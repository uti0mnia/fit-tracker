import sys
import re

def printEnumDescription(case: str, desc: str):
        print('\tcase .' + case + ':')
        print('\t\treturn "' + desc.title() + '"')

def printEnum(name, cases):
        cases.sort()

        # case
        print('case ' + ', '.join(cases) + ', none = -1')
        print('')

        # description
        caseDescriptions = []
        for case in cases:
                caseDescriptions.append(' '.join([x.capitalize() for x in re.sub( r"([A-Z])", r" \1", case).split()]))
        print('public var description: String {')
        print('\tswitch self {')
        for case, caseDesc in zip(cases, caseDescriptions):
                printEnumDescription(case, caseDesc)
        printEnumDescription('none', 'None')
        print('\t}')
        print('}')
        print('')

        # array
        print('public static var array: [' + name + '] {')
        print('\treturn [.' + ", .".join(cases) + ']')
        print('}')

def createBodyPart():
        bodyParts = ['arms', 'back', 'chest', 'core', 'legs', 'shoulders', 'olympic', 'fullBody', 'cardio']
        printEnum('BodyPart', bodyParts)

def createCategory():
        categories = ['assistedBodyweight', 'barbell', 'cardio', 'dumbbell', 'duration', 'machine', 'repsOnly', 'weightedBodyweight']
        printEnum('Category', categories)

createCategory()