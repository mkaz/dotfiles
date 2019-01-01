#!/usr/bin/env python

#-----------------------------------------------------------------------------
# mkpasswd.pl -- simple password generator using real words
#                not a great deal of entropy
#                I recommend using pwgen utility for real secure passwords
#-----------------------------------------------------------------------------

import math
import sys
import string
import random
import os


def randomWord():
    this_dir = os.path.dirname(os.path.realpath(__file__))
    wordfile = os.path.join(this_dir, "word-list-simple.txt")
    datafile = open(wordfile, 'r')
    for num, aline in enumerate(datafile):
      if random.randrange(num + 2): continue
      line = aline.rstrip()
    return line


def main():
    myrg = random.SystemRandom()
    password = randomWord() + " " + randomWord()
    if len(password) < 24 :
        password += " " + randomWord()

    if len(password) < 24 :
        password += " " + randomWord()

    print password


if __name__ == '__main__':
    main()
    sys.exit(0)

