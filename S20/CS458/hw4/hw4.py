# Wargen Guittap
# 5004493060 CS458 Assignment #4

from nltk.corpus import movie_reviews
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
import nltk
import random
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB


def build_raw_data():
    nltk.download('movie_reviews')
    nltk.download('stopwords')
    nltk.download('wordnet')

    raw_data = []
    stop_words = set(stopwords.words('english'))
    lemmatizer = WordNetLemmatizer()

    for category in movie_reviews.categories():
        for fileid in movie_reviews.fileids(category):
            review_words = movie_reviews.words(fileid)
            review_text = ''
            for word in review_words:
                # remove stop words
                if word not in stop_words and word.isalpha():
                    review_text += ' ' + lemmatizer.lemmatize(word)
            review_dictionary = {
                'text': review_text[1:], 'sentiment': category}
            raw_data.append(review_dictionary)

    return raw_data


def feature_selection(raw_data):
    texts = [i['text'] for i in raw_data]

    tfidf = TfidfVectorizer(min_df=2, max_df=0.5, ngram_range=(1, 2))
    features = tfidf.fit_transform(texts)

    result = pd.DataFrame(features.todense(),
                          columns=tfidf.get_feature_names())
    return result


def split_data(X, y):
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.25, random_state=42)

    return X_train, X_test, y_train, y_test


def model():
    raw_data = build_raw_data()
    data_frame = feature_selection(raw_data)
    sentiments = [i['sentiment'] for i in raw_data]
    X_train, X_test, y_train, y_test = split_data(data_frame, sentiments)

    clf = MultinomialNB()
    clf.fit(X_train, y_train)

    predicted_y_test = clf.predict(X_test)

    matches = 0
    for i in range(len(y_test)):
        if y_test[i] == predicted_y_test[i]:
            matches += 1
    print(str(matches/len(y_test)*100)+"%")


if __name__ == '__main__':
    model()
