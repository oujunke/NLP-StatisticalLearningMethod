# coding: utf-8
from math import erf, sqrt
import matplotlib.pyplot as plt
import numpy as np


def gauss(x, mu, sigma):
    '''求正太分布在x点处的概率'''
    return 1 / 2 * (1 + erf((x - mu) / (sigma * sqrt(2))))


def gauss_arr(x, mu, sigma):
    return np.array([gauss(i, mu, sigma) for i in x])


def averageWeight(samples, gamma, n):
    return np.array(samples).T.dot(np.array(gamma)) / n


def varianceWeight(height, gamma, mu, n):
    height_mu = np.array(height) - mu
    return np.array(gamma).T.dot(height_mu ** 2) / n


def isSame(cur, now):
    for i in range(len(cur)):
        if (cur[i] != now[i]):
            return False
    return True


if __name__ == "__main__":
    ####test#############################################
    X = np.arange(0.0, 500, 0.01)
    Y = gauss_arr(X, 250.65710021824577, 70)
    plt.plot(X, Y)
    plt.show()

    while 1:
        '''输入一个数时默认为标准正态分布
        输入三个数(空格隔开)时分别为期望、方差、x
        输入 stop 停止'''
        S = input('please input the parameters:\n')
        if S == 'stop': break
        try:
            L = [float(s) for s in S.split()]
        except:
            print('Input error!')
            continue
        if len(L) == 3:
            print('f(x)=%.5f' % gauss(L[0], L[1], L[2]))
        else:
            print('Input error!')
