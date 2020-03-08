# Wargen Guittap
# 5004493060 CS458 Assignment #5

import pandas as pd
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler


def model():
    X_train = pd.read_csv('train.csv', header=0, index_col=False)
    y_train = list(X_train['am'])
    X_train.drop(['car_model', 'hp', 'am', 'Unnamed: 12'],
                 axis=1, inplace=True)

    X_test = pd.read_csv('test.csv', header=0, index_col=False)
    y_test = list(X_test['am'])
    X_test.drop(['car_model', 'hp', 'am', 'Unnamed: 12'], axis=1, inplace=True)

    scaler = MinMaxScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.fit_transform(X_test)

    lr = LogisticRegression()
    lr.fit(X_train, y_train)

    y_pred = lr.predict(X_test)
    print("confusion matrix: \n", confusion_matrix(y_pred, y_test))
    print("accuracy score:", str(accuracy_score(y_test, y_pred)*100)+"%")


if __name__ == '__main__':
    model()
