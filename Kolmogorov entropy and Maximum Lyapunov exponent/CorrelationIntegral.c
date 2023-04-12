#include <math.h>
#include "mex.h"
#include "stdio.h"
#include "stdlib.h"
#include "matrix.h"

//---------------------------------------------------------------------------
// �����������
#define X prhs[0]           // ʱ�����У�������
#define T prhs[1]           // ʱ���ӳ�
#define M prhs[2]           // Ƕ��ά�� (����Ϊ����)
#define R prhs[3]           // �������� (����Ϊ����)
#define P prhs[4]           // ���ƶ��ݷ���,Ĭ��Ϊ1

// �����������
#define Cr plhs[0]

// ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
double GUANLIAN_JIFEN();

//---------------------------------------------------------------------------
void 
mexFunction (int nlhs, mxArray *plhs[],			// ��������������������������
			 int nrhs, const mxArray *prhs[])	// ��������������������������
{
    double *pX,*pR,*pCr,r,*pM,x_min,x_max,x_mean,x_width,tmp1;
    int n,len_m,len_r,tau,p,m,m_max,i,j;
        
   
    
    //---------------------------------------------------------------
    // ȡ���������
    pX = mxGetPr(X);                    // ʱ�����У���������
    n = max(mxGetM(X),mxGetN(X));       // ���г���
        
    tau = (int) mxGetScalar(T);           // ʱ���ӳ�      
    
    pM = mxGetPr(M);
    len_m = max(mxGetM(M),mxGetN(M));
    
    pR = mxGetPr(R);
    len_r = max(mxGetM(R),mxGetN(R));

    p = (int) mxGetScalar(P);           // ���ƶ��ݷ���,Ĭ��Ϊ1   
    
    // Ϊ������������ڴ�ռ�
	Cr = mxCreateDoubleMatrix(len_m,len_r,mxREAL); 
	
	// ȡ���������ָ��
	pCr = mxGetPr(Cr);
	
    // ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
    x_min = x_max = 0;
    tmp1 = 0;
    for (i=0;i<n;i++)
    {
        if (pX[i]>x_max)
            x_max = pX[i];
        if (pX[i]<x_min)
            x_min = pX[i];
        tmp1 = tmp1+pX[i];            
    }
    x_mean = tmp1/n;
    x_width = x_max-x_min;
    for (i=0;i<n;i++)
        pX[i] = (pX[i]-x_mean)/x_width;    
    
    for (i=0;i<len_m;i++)
        for (j=0;j<len_r;j++)
        {
            m = (int) pM[i];
            r = pR[j];
            pCr[j*len_m+i] = GUANLIAN_JIFEN(pX,n,tau,m,r,p);
        }
     return;
}

//-------------------------------------------------------------------------------

double GUANLIAN_JIFEN(double *pX,       // ʱ�����У���������
                          int lX,       // ���г���
                          int t,        // ʱ���ӳ� 
                          int m,        // Ƕ��ά�� 
                          double r,     // ��������r 
                          int p)        // ���ƶ��ݷ���,Ĭ��Ϊ1
{
    double c,tmp1,tmp2;
    int i,j1,j2,cXn;

    cXn = lX-(m-1)*t;                                // �ع����� xn ����
    
    tmp1 = 0;
    for (j1=0; j1<cXn; j1++)
    {   for (j2=j1+p; j2<cXn; j2++)
        {   for (i=0;i<m;i++)
            {
                tmp2 = fabs(pX[i*t+j1] - pX[i*t+j2]);    // ��i��,��j1����j2�ж�ӦԪ�����
                if (tmp2>r)
                {
                    tmp1 = tmp1 + 1;
                    break;
                }                
            }
        }
    }
    
    if (cXn<=1)
        c = 0;
    else
    {
        c = (double) 2/((cXn-p)*(cXn-p+1))*tmp1;
        c = 1 - c;
    }
    return c;
}

