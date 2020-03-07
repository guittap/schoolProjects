# Wargen Guittap
# 5004493060 CS458 Assignment #5

import pandas as pd
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from hw4 import split_data


def model():
    df = pd.read_csv('mtcars.csv', header=0, index_col=False)
    am = list(df['am'])
    df.drop(['car_model', 'hp', 'am'], axis=1, inplace=True)
    scaler = MinMaxScaler()
    df = scaler.fit_transform(df)

    X_train, X_test, y_train, y_test = split_data(df, am)

    lr = LogisticRegression()
    lr.fit(X_train, y_train)

    y_pred = lr.predict(X_test)
    print("confusion matrix: \n", confusion_matrix(y_pred, y_test))
    print("accuracy score:", str(accuracy_score(y_test, y_pred)*100)+"%")


if __name__ == '__main__':
    model()
