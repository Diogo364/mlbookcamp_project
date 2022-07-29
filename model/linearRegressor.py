from sklearn.base import BaseEstimator
from sklearn.utils.validation import check_X_y, check_array, check_is_fitted
from sklearn.utils.estimator_checks import check_estimator
import numpy as np

class LinearRegressor(BaseEstimator):
    
    def __init__(self, use_bias=True, regularization_factor=None):
        self.use_bias = use_bias
        self.regularization_factor = regularization_factor

    def __apply_regularization_factor(self, X):
        return X + (np.eye(len(X)) * self.regularization_factor)

    def __append_bias(self, X):
        bias = np.ones(len(X))
        return np.column_stack([bias, X])
        
    def fit(self, X, y):
        
        X, y = check_X_y(X, y)

        if self.use_bias:
            X = self.__append_bias(X)
        
        XTX = X.T.dot(X)
        
        if self.regularization_factor is not None:
            XTX = self.__apply_regularization_factor(XTX)
        
        try:
            XTX_inv = np.linalg.inv(XTX)
        except np.linalg.LinAlgError:
            print('Singular Matrix, please use an regularization factor.')
            return
        
        W = XTX_inv @ X.T @ y
        if self.use_bias:
            self.w0_, self.wfull_ = W[0], W[1:]
        else:
            self.w0_, self.wfull_ = 0, W[1:]
        return self
    
    def predict(self, X):
        check_is_fitted(self)

        X = check_array(X)
        
        return self.w0_ + (X @ self.wfull_)
        
        
        

if __name__ == '__main__':
    check_estimator(LinearRegressor())