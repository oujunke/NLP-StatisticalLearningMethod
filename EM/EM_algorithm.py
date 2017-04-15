from utils import gauss, averageWeight, varianceWeight, isSame
import matplotlib.pyplot as plt


def calcEM(height):
    ##########初始化#################
    N = len(height)
    gp = 0.5  # girl probability
    bp = 0.5  # boy probability
    gmu, gsigma = min(height), 18  # 先验：直接取最大和最小值
    bmu, bsigma = max(height), 20
    # r(i,k):第i个样本由第k个组份生成的概率
    ggamma = [0.0 for i in range(N)]  # 第i个样本由女性生成的概率
    bgamma = [0.0 for i in range(N)]  # 第i个样本由男性生成的概率
    cur = [gp, bp, gmu, gsigma, bmu, bsigma]
    now = []
    times = 0
    ##########迭代更新###############
    while times < 100:
        i = 0
        for x in height:
            ggamma[i] = gp * gauss(x, gmu, gsigma)
            bgamma[i] = bp * gauss(x, bmu, bsigma)
            s = ggamma[i] + bgamma[i]
            ggamma[i] /= s
            bgamma[i] /= s
            i += 1

        gn = sum(ggamma)
        gp = float(gn) / float(N)
        bn = sum(bgamma)
        bp = float(bn) / float(N)
        gmu = averageWeight(height, ggamma, gn)
        gsigma = varianceWeight(height, ggamma, gmu, gn)
        bmu = averageWeight(height, bgamma, bn)
        bsigma = varianceWeight(height, bgamma, bmu, bn)

        now = [gp, bp, gmu, gsigma, bmu, bsigma]
        if isSame(cur, now):
            break
        cur = now
        print("Times:\t", times)
        print("Girl mean/gsigma:\t", gmu, gsigma)
        print("Boy mean/bsigma:\t", bmu, bsigma)
        print("Boy/Girl:\t", bn, gn, bn + gn)
        print()
        times += 1
    return now


if __name__ == "__main__":
    height = [147, 163, 157, 160, 162, 158, 155, 165, 161, 159, 163, 158, 155, 162, 157, 159, 152, 156, 165, 154, 156,
              162, 162, 164, 168, 176, 169, 178, 165, 183, 171, 179, 172, 173, 172, 175, 160, 160, 160, 175, 163, 181,
              172, 175]
    calcEM(height)
    plt.plot(height)
    plt.show()
