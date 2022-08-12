within Buildings.Controls.OBC.Utilities.PIDWithAutotuning.AutoTuner.Amigo.Validation;
model PIDGain "Test model for PIDGain"
  Buildings.Controls.OBC.Utilities.PIDWithAutotuning.AutoTuner.Amigo.PIDGain pIDGain
    "Calculate the control gain for a PID controller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable ReferenceData(table=[0,1,0.5,0.3,0.95,0.446,
        0.127; 0.002,1.002,0.501,0.301,0.948,0.447,0.127; 0.004,1.004,0.502,
        0.301,0.946,0.447,0.128; 0.006,1.006,0.503,0.302,0.944,0.448,0.128;
        0.008,1.008,0.504,0.302,0.942,0.449,0.128; 0.01,1.01,0.505,0.303,0.941,
        0.45,0.128; 0.012,1.012,0.506,0.304,0.939,0.451,0.129; 0.014,1.014,
        0.507,0.304,0.937,0.452,0.129; 0.016,1.016,0.508,0.305,0.935,0.453,
        0.129; 0.018,1.018,0.509,0.305,0.933,0.454,0.129; 0.02,1.02,0.51,0.306,
        0.931,0.455,0.13; 0.022,1.022,0.511,0.307,0.93,0.456,0.13; 0.024,1.024,
        0.512,0.307,0.928,0.456,0.13; 0.026,1.026,0.513,0.308,0.926,0.457,0.13;
        0.028,1.028,0.514,0.308,0.924,0.458,0.131; 0.03,1.03,0.515,0.309,0.922,
        0.459,0.131; 0.032,1.032,0.516,0.31,0.921,0.46,0.131; 0.034,1.034,0.517,
        0.31,0.919,0.461,0.131; 0.036,1.036,0.518,0.311,0.917,0.462,0.132;
        0.038,1.038,0.519,0.311,0.915,0.463,0.132; 0.04,1.04,0.52,0.312,0.913,
        0.464,0.132; 0.042,1.042,0.521,0.313,0.912,0.464,0.132; 0.044,1.044,
        0.522,0.313,0.91,0.465,0.133; 0.046,1.046,0.523,0.314,0.908,0.466,0.133;
        0.048,1.048,0.524,0.314,0.906,0.467,0.133; 0.05,1.05,0.525,0.315,0.905,
        0.468,0.133; 0.052,1.052,0.526,0.316,0.903,0.469,0.134; 0.054,1.054,
        0.527,0.316,0.901,0.47,0.134; 0.056,1.056,0.528,0.317,0.9,0.471,0.134;
        0.058,1.058,0.529,0.317,0.898,0.472,0.134; 0.06,1.06,0.53,0.318,0.896,
        0.472,0.135; 0.062,1.062,0.531,0.319,0.895,0.473,0.135; 0.064,1.064,
        0.532,0.319,0.893,0.474,0.135; 0.066,1.066,0.533,0.32,0.891,0.475,0.136;
        0.068,1.068,0.534,0.32,0.89,0.476,0.136; 0.07,1.07,0.535,0.321,0.888,
        0.477,0.136; 0.072,1.072,0.536,0.322,0.886,0.478,0.136; 0.074,1.074,
        0.537,0.322,0.885,0.479,0.137; 0.076,1.076,0.538,0.323,0.883,0.48,0.137;
        0.078,1.078,0.539,0.323,0.881,0.48,0.137; 0.08,1.08,0.54,0.324,0.88,
        0.481,0.137; 0.082,1.082,0.541,0.325,0.878,0.482,0.138; 0.084,1.084,
        0.542,0.325,0.876,0.483,0.138; 0.086,1.086,0.543,0.326,0.875,0.484,
        0.138; 0.088,1.088,0.544,0.326,0.873,0.485,0.138; 0.09,1.09,0.545,0.327,
        0.872,0.486,0.139; 0.092,1.092,0.546,0.328,0.87,0.487,0.139; 0.094,
        1.094,0.547,0.328,0.868,0.488,0.139; 0.096,1.096,0.548,0.329,0.867,
        0.489,0.139; 0.098,1.098,0.549,0.329,0.865,0.489,0.14; 0.1,1.1,0.55,
        0.33,0.864,0.49,0.14; 0.102,1.102,0.551,0.331,0.862,0.491,0.14; 0.104,
        1.104,0.552,0.331,0.861,0.492,0.14; 0.106,1.106,0.553,0.332,0.859,0.493,
        0.141; 0.108,1.108,0.554,0.332,0.857,0.494,0.141; 0.11,1.11,0.555,0.333,
        0.856,0.495,0.141; 0.112,1.112,0.556,0.334,0.854,0.496,0.141; 0.114,
        1.114,0.557,0.334,0.853,0.497,0.142; 0.116,1.116,0.558,0.335,0.851,
        0.497,0.142; 0.118,1.118,0.559,0.335,0.85,0.498,0.142; 0.12,1.12,0.56,
        0.336,0.848,0.499,0.142; 0.122,1.122,0.561,0.337,0.847,0.5,0.143; 0.124,
        1.124,0.562,0.337,0.845,0.501,0.143; 0.126,1.126,0.563,0.338,0.844,
        0.502,0.143; 0.128,1.128,0.564,0.338,0.842,0.503,0.143; 0.13,1.13,0.565,
        0.339,0.841,0.504,0.144; 0.132,1.132,0.566,0.34,0.839,0.505,0.144;
        0.134,1.134,0.567,0.34,0.838,0.505,0.144; 0.136,1.136,0.568,0.341,0.836,
        0.506,0.144; 0.138,1.138,0.569,0.341,0.835,0.507,0.145; 0.14,1.14,0.57,
        0.342,0.833,0.508,0.145; 0.142,1.142,0.571,0.343,0.832,0.509,0.145;
        0.144,1.144,0.572,0.343,0.83,0.51,0.145; 0.146,1.146,0.573,0.344,0.829,
        0.511,0.146; 0.148,1.148,0.574,0.344,0.828,0.512,0.146; 0.15,1.15,0.575,
        0.345,0.826,0.513,0.146; 0.152,1.152,0.576,0.346,0.825,0.513,0.146;
        0.154,1.154,0.577,0.346,0.823,0.514,0.147; 0.156,1.156,0.578,0.347,
        0.822,0.515,0.147; 0.158,1.158,0.579,0.347,0.82,0.516,0.147; 0.16,1.16,
        0.58,0.348,0.819,0.517,0.147; 0.162,1.162,0.581,0.349,0.818,0.518,0.148;
        0.164,1.164,0.582,0.349,0.816,0.519,0.148; 0.166,1.166,0.583,0.35,0.815,
        0.52,0.148; 0.168,1.168,0.584,0.35,0.813,0.521,0.148; 0.17,1.17,0.585,
        0.351,0.812,0.521,0.149; 0.172,1.172,0.586,0.352,0.811,0.522,0.149;
        0.174,1.174,0.587,0.352,0.809,0.523,0.149; 0.176,1.176,0.588,0.353,
        0.808,0.524,0.149; 0.178,1.178,0.589,0.353,0.806,0.525,0.15; 0.18,1.18,
        0.59,0.354,0.805,0.526,0.15; 0.182,1.182,0.591,0.355,0.804,0.527,0.15;
        0.184,1.184,0.592,0.355,0.802,0.528,0.151; 0.186,1.186,0.593,0.356,
        0.801,0.529,0.151; 0.188,1.188,0.594,0.356,0.8,0.53,0.151; 0.19,1.19,
        0.595,0.357,0.798,0.53,0.151; 0.192,1.192,0.596,0.358,0.797,0.531,0.152;
        0.194,1.194,0.597,0.358,0.796,0.532,0.152; 0.196,1.196,0.598,0.359,
        0.794,0.533,0.152; 0.198,1.198,0.599,0.359,0.793,0.534,0.152; 0.2,1.2,
        0.6,0.36,0.792,0.535,0.153; 0.202,1.202,0.601,0.361,0.79,0.536,0.153;
        0.204,1.204,0.602,0.361,0.789,0.537,0.153; 0.206,1.206,0.603,0.362,
        0.788,0.538,0.153; 0.208,1.208,0.604,0.362,0.786,0.538,0.154; 0.21,1.21,
        0.605,0.363,0.785,0.539,0.154; 0.212,1.212,0.606,0.364,0.784,0.54,0.154;
        0.214,1.214,0.607,0.364,0.783,0.541,0.154; 0.216,1.216,0.608,0.365,
        0.781,0.542,0.155; 0.218,1.218,0.609,0.365,0.78,0.543,0.155; 0.22,1.22,
        0.61,0.366,0.779,0.544,0.155; 0.222,1.222,0.611,0.367,0.777,0.545,0.155;
        0.224,1.224,0.612,0.367,0.776,0.546,0.156; 0.226,1.226,0.613,0.368,
        0.775,0.546,0.156; 0.228,1.228,0.614,0.368,0.774,0.547,0.156; 0.23,1.23,
        0.615,0.369,0.772,0.548,0.156; 0.232,1.232,0.616,0.37,0.771,0.549,0.157;
        0.234,1.234,0.617,0.37,0.77,0.55,0.157; 0.236,1.236,0.618,0.371,0.769,
        0.551,0.157; 0.238,1.238,0.619,0.371,0.767,0.552,0.157; 0.24,1.24,0.62,
        0.372,0.766,0.553,0.158; 0.242,1.242,0.621,0.373,0.765,0.554,0.158;
        0.244,1.244,0.622,0.373,0.764,0.554,0.158; 0.246,1.246,0.623,0.374,
        0.762,0.555,0.158; 0.248,1.248,0.624,0.374,0.761,0.556,0.159; 0.25,1.25,
        0.625,0.375,0.76,0.557,0.159; 0.252,1.252,0.626,0.376,0.759,0.558,0.159;
        0.254,1.254,0.627,0.376,0.758,0.559,0.159; 0.256,1.256,0.628,0.377,
        0.756,0.56,0.16; 0.258,1.258,0.629,0.377,0.755,0.561,0.16; 0.26,1.26,
        0.63,0.378,0.754,0.562,0.16; 0.262,1.262,0.631,0.379,0.753,0.562,0.16;
        0.264,1.264,0.632,0.379,0.752,0.563,0.161; 0.266,1.266,0.633,0.38,0.75,
        0.564,0.161; 0.268,1.268,0.634,0.38,0.749,0.565,0.161; 0.27,1.27,0.635,
        0.381,0.748,0.566,0.161; 0.272,1.272,0.636,0.382,0.747,0.567,0.162;
        0.274,1.274,0.637,0.382,0.746,0.568,0.162; 0.276,1.276,0.638,0.383,
        0.745,0.569,0.162; 0.278,1.278,0.639,0.383,0.743,0.57,0.162; 0.28,1.28,
        0.64,0.384,0.742,0.571,0.163; 0.282,1.282,0.641,0.385,0.741,0.571,0.163;
        0.284,1.284,0.642,0.385,0.74,0.572,0.163; 0.286,1.286,0.643,0.386,0.739,
        0.573,0.163; 0.288,1.288,0.644,0.386,0.738,0.574,0.164; 0.29,1.29,0.645,
        0.387,0.736,0.575,0.164; 0.292,1.292,0.646,0.388,0.735,0.576,0.164;
        0.294,1.294,0.647,0.388,0.734,0.577,0.164; 0.296,1.296,0.648,0.389,
        0.733,0.578,0.165; 0.298,1.298,0.649,0.389,0.732,0.579,0.165; 0.3,1.3,
        0.65,0.39,0.731,0.579,0.165; 0.302,1.302,0.651,0.391,0.73,0.58,0.166;
        0.304,1.304,0.652,0.391,0.729,0.581,0.166; 0.306,1.306,0.653,0.392,
        0.727,0.582,0.166; 0.308,1.308,0.654,0.392,0.726,0.583,0.166; 0.31,1.31,
        0.655,0.393,0.725,0.584,0.167; 0.312,1.312,0.656,0.394,0.724,0.585,
        0.167; 0.314,1.314,0.657,0.394,0.723,0.586,0.167; 0.316,1.316,0.658,
        0.395,0.722,0.587,0.167; 0.318,1.318,0.659,0.395,0.721,0.587,0.168;
        0.32,1.32,0.66,0.396,0.72,0.588,0.168; 0.322,1.322,0.661,0.397,0.719,
        0.589,0.168; 0.324,1.324,0.662,0.397,0.718,0.59,0.168; 0.326,1.326,
        0.663,0.398,0.716,0.591,0.169; 0.328,1.328,0.664,0.398,0.715,0.592,
        0.169; 0.33,1.33,0.665,0.399,0.714,0.593,0.169; 0.332,1.332,0.666,0.4,
        0.713,0.594,0.169; 0.334,1.334,0.667,0.4,0.712,0.595,0.17; 0.336,1.336,
        0.668,0.401,0.711,0.595,0.17; 0.338,1.338,0.669,0.401,0.71,0.596,0.17;
        0.34,1.34,0.67,0.402,0.709,0.597,0.17; 0.342,1.342,0.671,0.403,0.708,
        0.598,0.171; 0.344,1.344,0.672,0.403,0.707,0.599,0.171; 0.346,1.346,
        0.673,0.404,0.706,0.6,0.171; 0.348,1.348,0.674,0.404,0.705,0.601,0.171;
        0.35,1.35,0.675,0.405,0.704,0.602,0.172; 0.352,1.352,0.676,0.406,0.703,
        0.603,0.172; 0.354,1.354,0.677,0.406,0.702,0.603,0.172; 0.356,1.356,
        0.678,0.407,0.701,0.604,0.172; 0.358,1.358,0.679,0.407,0.7,0.605,0.173;
        0.36,1.36,0.68,0.408,0.699,0.606,0.173; 0.362,1.362,0.681,0.409,0.698,
        0.607,0.173; 0.364,1.364,0.682,0.409,0.696,0.608,0.173; 0.366,1.366,
        0.683,0.41,0.695,0.609,0.174; 0.368,1.368,0.684,0.41,0.694,0.61,0.174;
        0.37,1.37,0.685,0.411,0.693,0.611,0.174; 0.372,1.372,0.686,0.412,0.692,
        0.612,0.174; 0.374,1.374,0.687,0.412,0.691,0.612,0.175; 0.376,1.376,
        0.688,0.413,0.69,0.613,0.175; 0.378,1.378,0.689,0.413,0.689,0.614,0.175;
        0.38,1.38,0.69,0.414,0.688,0.615,0.175; 0.382,1.382,0.691,0.415,0.687,
        0.616,0.176; 0.384,1.384,0.692,0.415,0.686,0.617,0.176; 0.386,1.386,
        0.693,0.416,0.685,0.618,0.176; 0.388,1.388,0.694,0.416,0.684,0.619,
        0.176; 0.39,1.39,0.695,0.417,0.683,0.62,0.177; 0.392,1.392,0.696,0.418,
        0.682,0.62,0.177; 0.394,1.394,0.697,0.418,0.681,0.621,0.177; 0.396,
        1.396,0.698,0.419,0.681,0.622,0.177; 0.398,1.398,0.699,0.419,0.68,0.623,
        0.178; 0.4,1.4,0.7,0.42,0.679,0.624,0.178; 0.402,1.402,0.701,0.421,
        0.678,0.625,0.178; 0.404,1.404,0.702,0.421,0.677,0.626,0.178; 0.406,
        1.406,0.703,0.422,0.676,0.627,0.179; 0.408,1.408,0.704,0.422,0.675,
        0.628,0.179; 0.41,1.41,0.705,0.423,0.674,0.628,0.179; 0.412,1.412,0.706,
        0.424,0.673,0.629,0.179; 0.414,1.414,0.707,0.424,0.672,0.63,0.18; 0.416,
        1.416,0.708,0.425,0.671,0.631,0.18; 0.418,1.418,0.709,0.425,0.67,0.632,
        0.18; 0.42,1.42,0.71,0.426,0.669,0.633,0.181; 0.422,1.422,0.711,0.427,
        0.668,0.634,0.181; 0.424,1.424,0.712,0.427,0.667,0.635,0.181; 0.426,
        1.426,0.713,0.428,0.666,0.636,0.181; 0.428,1.428,0.714,0.428,0.665,
        0.636,0.182; 0.43,1.43,0.715,0.429,0.664,0.637,0.182; 0.432,1.432,0.716,
        0.43,0.663,0.638,0.182; 0.434,1.434,0.717,0.43,0.662,0.639,0.182; 0.436,
        1.436,0.718,0.431,0.662,0.64,0.183; 0.438,1.438,0.719,0.431,0.661,0.641,
        0.183; 0.44,1.44,0.72,0.432,0.66,0.642,0.183; 0.442,1.442,0.721,0.433,
        0.659,0.643,0.183; 0.444,1.444,0.722,0.433,0.658,0.644,0.184; 0.446,
        1.446,0.723,0.434,0.657,0.645,0.184; 0.448,1.448,0.724,0.434,0.656,
        0.645,0.184; 0.45,1.45,0.725,0.435,0.655,0.646,0.184; 0.452,1.452,0.726,
        0.436,0.654,0.647,0.185; 0.454,1.454,0.727,0.436,0.653,0.648,0.185;
        0.456,1.456,0.728,0.437,0.652,0.649,0.185; 0.458,1.458,0.729,0.437,
        0.652,0.65,0.185; 0.46,1.46,0.73,0.438,0.651,0.651,0.186; 0.462,1.462,
        0.731,0.439,0.65,0.652,0.186; 0.464,1.464,0.732,0.439,0.649,0.653,0.186;
        0.466,1.466,0.733,0.44,0.648,0.653,0.186; 0.468,1.468,0.734,0.44,0.647,
        0.654,0.187; 0.47,1.47,0.735,0.441,0.646,0.655,0.187; 0.472,1.472,0.736,
        0.442,0.645,0.656,0.187; 0.474,1.474,0.737,0.442,0.645,0.657,0.187;
        0.476,1.476,0.738,0.443,0.644,0.658,0.188; 0.478,1.478,0.739,0.443,
        0.643,0.659,0.188; 0.48,1.48,0.74,0.444,0.642,0.66,0.188; 0.482,1.482,
        0.741,0.445,0.641,0.661,0.188; 0.484,1.484,0.742,0.445,0.64,0.661,0.189;
        0.486,1.486,0.743,0.446,0.639,0.662,0.189; 0.488,1.488,0.744,0.446,
        0.638,0.663,0.189; 0.49,1.49,0.745,0.447,0.638,0.664,0.189; 0.492,1.492,
        0.746,0.448,0.637,0.665,0.19; 0.494,1.494,0.747,0.448,0.636,0.666,0.19;
        0.496,1.496,0.748,0.449,0.635,0.667,0.19; 0.498,1.498,0.749,0.449,0.634,
        0.668,0.19; 0.5,1.5,0.75,0.45,0.633,0.669,0.191; 0.502,1.502,0.751,
        0.451,0.632,0.669,0.191; 0.504,1.504,0.752,0.451,0.632,0.67,0.191;
        0.506,1.506,0.753,0.452,0.631,0.671,0.191; 0.508,1.508,0.754,0.452,0.63,
        0.672,0.192; 0.51,1.51,0.755,0.453,0.629,0.673,0.192; 0.512,1.512,0.756,
        0.454,0.628,0.674,0.192; 0.514,1.514,0.757,0.454,0.627,0.675,0.192;
        0.516,1.516,0.758,0.455,0.627,0.676,0.193; 0.518,1.518,0.759,0.455,
        0.626,0.677,0.193; 0.52,1.52,0.76,0.456,0.625,0.677,0.193; 0.522,1.522,
        0.761,0.457,0.624,0.678,0.193; 0.524,1.524,0.762,0.457,0.623,0.679,
        0.194; 0.526,1.526,0.763,0.458,0.623,0.68,0.194; 0.528,1.528,0.764,
        0.458,0.622,0.681,0.194; 0.53,1.53,0.765,0.459,0.621,0.682,0.194; 0.532,
        1.532,0.766,0.46,0.62,0.683,0.195; 0.534,1.534,0.767,0.46,0.619,0.684,
        0.195; 0.536,1.536,0.768,0.461,0.618,0.685,0.195; 0.538,1.538,0.769,
        0.461,0.618,0.686,0.196; 0.54,1.54,0.77,0.462,0.617,0.686,0.196; 0.542,
        1.542,0.771,0.463,0.616,0.687,0.196; 0.544,1.544,0.772,0.463,0.615,
        0.688,0.196; 0.546,1.546,0.773,0.464,0.614,0.689,0.197; 0.548,1.548,
        0.774,0.464,0.614,0.69,0.197; 0.55,1.55,0.775,0.465,0.613,0.691,0.197;
        0.552,1.552,0.776,0.466,0.612,0.692,0.197; 0.554,1.554,0.777,0.466,
        0.611,0.693,0.198; 0.556,1.556,0.778,0.467,0.611,0.694,0.198; 0.558,
        1.558,0.779,0.467,0.61,0.694,0.198; 0.56,1.56,0.78,0.468,0.609,0.695,
        0.198; 0.562,1.562,0.781,0.469,0.608,0.696,0.199; 0.564,1.564,0.782,
        0.469,0.607,0.697,0.199; 0.566,1.566,0.783,0.47,0.607,0.698,0.199;
        0.568,1.568,0.784,0.47,0.606,0.699,0.199; 0.57,1.57,0.785,0.471,0.605,
        0.7,0.2; 0.572,1.572,0.786,0.472,0.604,0.701,0.2; 0.574,1.574,0.787,
        0.472,0.604,0.702,0.2; 0.576,1.576,0.788,0.473,0.603,0.702,0.2; 0.578,
        1.578,0.789,0.473,0.602,0.703,0.201; 0.58,1.58,0.79,0.474,0.601,0.704,
        0.201; 0.582,1.582,0.791,0.475,0.601,0.705,0.201; 0.584,1.584,0.792,
        0.475,0.6,0.706,0.201; 0.586,1.586,0.793,0.476,0.599,0.707,0.202; 0.588,
        1.588,0.794,0.476,0.598,0.708,0.202; 0.59,1.59,0.795,0.477,0.597,0.709,
        0.202; 0.592,1.592,0.796,0.478,0.597,0.71,0.202; 0.594,1.594,0.797,
        0.478,0.596,0.71,0.203; 0.596,1.596,0.798,0.479,0.595,0.711,0.203;
        0.598,1.598,0.799,0.479,0.594,0.712,0.203; 0.6,1.6,0.8,0.48,0.594,0.713,
        0.203; 0.602,1.602,0.801,0.481,0.593,0.714,0.204; 0.604,1.604,0.802,
        0.481,0.592,0.715,0.204; 0.606,1.606,0.803,0.482,0.592,0.716,0.204;
        0.608,1.608,0.804,0.482,0.591,0.717,0.204; 0.61,1.61,0.805,0.483,0.59,
        0.718,0.205; 0.612,1.612,0.806,0.484,0.589,0.718,0.205; 0.614,1.614,
        0.807,0.484,0.589,0.719,0.205; 0.616,1.616,0.808,0.485,0.588,0.72,0.205;
        0.618,1.618,0.809,0.485,0.587,0.721,0.206; 0.62,1.62,0.81,0.486,0.586,
        0.722,0.206; 0.622,1.622,0.811,0.487,0.586,0.723,0.206; 0.624,1.624,
        0.812,0.487,0.585,0.724,0.206; 0.626,1.626,0.813,0.488,0.584,0.725,
        0.207; 0.628,1.628,0.814,0.488,0.584,0.726,0.207; 0.63,1.63,0.815,0.489,
        0.583,0.727,0.207; 0.632,1.632,0.816,0.49,0.582,0.727,0.207; 0.634,
        1.634,0.817,0.49,0.581,0.728,0.208; 0.636,1.636,0.818,0.491,0.581,0.729,
        0.208; 0.638,1.638,0.819,0.491,0.58,0.73,0.208; 0.64,1.64,0.82,0.492,
        0.579,0.731,0.208; 0.642,1.642,0.821,0.493,0.579,0.732,0.209; 0.644,
        1.644,0.822,0.493,0.578,0.733,0.209; 0.646,1.646,0.823,0.494,0.577,
        0.734,0.209; 0.648,1.648,0.824,0.494,0.576,0.735,0.209; 0.65,1.65,0.825,
        0.495,0.576,0.735,0.21; 0.652,1.652,0.826,0.496,0.575,0.736,0.21; 0.654,
        1.654,0.827,0.496,0.574,0.737,0.21; 0.656,1.656,0.828,0.497,0.574,0.738,
        0.211; 0.658,1.658,0.829,0.497,0.573,0.739,0.211; 0.66,1.66,0.83,0.498,
        0.572,0.74,0.211; 0.662,1.662,0.831,0.499,0.572,0.741,0.211; 0.664,
        1.664,0.832,0.499,0.571,0.742,0.212; 0.666,1.666,0.833,0.5,0.57,0.743,
        0.212; 0.668,1.668,0.834,0.5,0.57,0.743,0.212; 0.67,1.67,0.835,0.501,
        0.569,0.744,0.212; 0.672,1.672,0.836,0.502,0.568,0.745,0.213; 0.674,
        1.674,0.837,0.502,0.568,0.746,0.213; 0.676,1.676,0.838,0.503,0.567,
        0.747,0.213; 0.678,1.678,0.839,0.503,0.566,0.748,0.213; 0.68,1.68,0.84,
        0.504,0.565,0.749,0.214; 0.682,1.682,0.841,0.505,0.565,0.75,0.214;
        0.684,1.684,0.842,0.505,0.564,0.751,0.214; 0.686,1.686,0.843,0.506,
        0.563,0.751,0.214; 0.688,1.688,0.844,0.506,0.563,0.752,0.215; 0.69,1.69,
        0.845,0.507,0.562,0.753,0.215; 0.692,1.692,0.846,0.508,0.561,0.754,
        0.215; 0.694,1.694,0.847,0.508,0.561,0.755,0.215; 0.696,1.696,0.848,
        0.509,0.56,0.756,0.216; 0.698,1.698,0.849,0.509,0.559,0.757,0.216; 0.7,
        1.7,0.85,0.51,0.559,0.758,0.216; 0.702,1.702,0.851,0.511,0.558,0.759,
        0.216; 0.704,1.704,0.852,0.511,0.558,0.759,0.217; 0.706,1.706,0.853,
        0.512,0.557,0.76,0.217; 0.708,1.708,0.854,0.512,0.556,0.761,0.217; 0.71,
        1.71,0.855,0.513,0.556,0.762,0.217; 0.712,1.712,0.856,0.514,0.555,0.763,
        0.218; 0.714,1.714,0.857,0.514,0.554,0.764,0.218; 0.716,1.716,0.858,
        0.515,0.554,0.765,0.218; 0.718,1.718,0.859,0.515,0.553,0.766,0.218;
        0.72,1.72,0.86,0.516,0.552,0.767,0.219; 0.722,1.722,0.861,0.517,0.552,
        0.768,0.219; 0.724,1.724,0.862,0.517,0.551,0.768,0.219; 0.726,1.726,
        0.863,0.518,0.55,0.769,0.219; 0.728,1.728,0.864,0.518,0.55,0.77,0.22;
        0.73,1.73,0.865,0.519,0.549,0.771,0.22; 0.732,1.732,0.866,0.52,0.548,
        0.772,0.22; 0.734,1.734,0.867,0.52,0.548,0.773,0.22; 0.736,1.736,0.868,
        0.521,0.547,0.774,0.221; 0.738,1.738,0.869,0.521,0.547,0.775,0.221;
        0.74,1.74,0.87,0.522,0.546,0.776,0.221; 0.742,1.742,0.871,0.523,0.545,
        0.776,0.221; 0.744,1.744,0.872,0.523,0.545,0.777,0.222; 0.746,1.746,
        0.873,0.524,0.544,0.778,0.222; 0.748,1.748,0.874,0.524,0.543,0.779,
        0.222; 0.75,1.75,0.875,0.525,0.543,0.78,0.222; 0.752,1.752,0.876,0.526,
        0.542,0.781,0.223; 0.754,1.754,0.877,0.526,0.542,0.782,0.223; 0.756,
        1.756,0.878,0.527,0.541,0.783,0.223; 0.758,1.758,0.879,0.527,0.54,0.784,
        0.223; 0.76,1.76,0.88,0.528,0.54,0.784,0.224; 0.762,1.762,0.881,0.529,
        0.539,0.785,0.224; 0.764,1.764,0.882,0.529,0.539,0.786,0.224; 0.766,
        1.766,0.883,0.53,0.538,0.787,0.224; 0.768,1.768,0.884,0.53,0.537,0.788,
        0.225; 0.77,1.77,0.885,0.531,0.537,0.789,0.225; 0.772,1.772,0.886,0.532,
        0.536,0.79,0.225; 0.774,1.774,0.887,0.532,0.536,0.791,0.226; 0.776,
        1.776,0.888,0.533,0.535,0.792,0.226; 0.778,1.778,0.889,0.533,0.534,
        0.792,0.226; 0.78,1.78,0.89,0.534,0.534,0.793,0.226; 0.782,1.782,0.891,
        0.535,0.533,0.794,0.227; 0.784,1.784,0.892,0.535,0.533,0.795,0.227;
        0.786,1.786,0.893,0.536,0.532,0.796,0.227; 0.788,1.788,0.894,0.536,
        0.531,0.797,0.227; 0.79,1.79,0.895,0.537,0.531,0.798,0.228; 0.792,1.792,
        0.896,0.538,0.53,0.799,0.228; 0.794,1.794,0.897,0.538,0.53,0.8,0.228;
        0.796,1.796,0.898,0.539,0.529,0.801,0.228; 0.798,1.798,0.899,0.539,
        0.528,0.801,0.229; 0.8,1.8,0.9,0.54,0.528,0.802,0.229; 0.802,1.802,
        0.901,0.541,0.527,0.803,0.229; 0.804,1.804,0.902,0.541,0.527,0.804,
        0.229; 0.806,1.806,0.903,0.542,0.526,0.805,0.23; 0.808,1.808,0.904,
        0.542,0.525,0.806,0.23; 0.81,1.81,0.905,0.543,0.525,0.807,0.23; 0.812,
        1.812,0.906,0.544,0.524,0.808,0.23; 0.814,1.814,0.907,0.544,0.524,0.809,
        0.231; 0.816,1.816,0.908,0.545,0.523,0.809,0.231; 0.818,1.818,0.909,
        0.545,0.523,0.81,0.231; 0.82,1.82,0.91,0.546,0.522,0.811,0.231; 0.822,
        1.822,0.911,0.547,0.521,0.812,0.232; 0.824,1.824,0.912,0.547,0.521,
        0.813,0.232; 0.826,1.826,0.913,0.548,0.52,0.814,0.232; 0.828,1.828,
        0.914,0.548,0.52,0.815,0.232; 0.83,1.83,0.915,0.549,0.519,0.816,0.233;
        0.832,1.832,0.916,0.55,0.519,0.817,0.233; 0.834,1.834,0.917,0.55,0.518,
        0.817,0.233; 0.836,1.836,0.918,0.551,0.517,0.818,0.233; 0.838,1.838,
        0.919,0.551,0.517,0.819,0.234; 0.84,1.84,0.92,0.552,0.516,0.82,0.234;
        0.842,1.842,0.921,0.553,0.516,0.821,0.234; 0.844,1.844,0.922,0.553,
        0.515,0.822,0.234; 0.846,1.846,0.923,0.554,0.515,0.823,0.235; 0.848,
        1.848,0.924,0.554,0.514,0.824,0.235; 0.85,1.85,0.925,0.555,0.514,0.825,
        0.235; 0.852,1.852,0.926,0.556,0.513,0.825,0.235; 0.854,1.854,0.927,
        0.556,0.512,0.826,0.236; 0.856,1.856,0.928,0.557,0.512,0.827,0.236;
        0.858,1.858,0.929,0.557,0.511,0.828,0.236; 0.86,1.86,0.93,0.558,0.511,
        0.829,0.236; 0.862,1.862,0.931,0.559,0.51,0.83,0.237; 0.864,1.864,0.932,
        0.559,0.51,0.831,0.237; 0.866,1.866,0.933,0.56,0.509,0.832,0.237; 0.868,
        1.868,0.934,0.56,0.509,0.833,0.237; 0.87,1.87,0.935,0.561,0.508,0.833,
        0.238; 0.872,1.872,0.936,0.562,0.507,0.834,0.238; 0.874,1.874,0.937,
        0.562,0.507,0.835,0.238; 0.876,1.876,0.938,0.563,0.506,0.836,0.238;
        0.878,1.878,0.939,0.563,0.506,0.837,0.239; 0.88,1.88,0.94,0.564,0.505,
        0.838,0.239; 0.882,1.882,0.941,0.565,0.505,0.839,0.239; 0.884,1.884,
        0.942,0.565,0.504,0.84,0.239; 0.886,1.886,0.943,0.566,0.504,0.841,0.24;
        0.888,1.888,0.944,0.566,0.503,0.842,0.24; 0.89,1.89,0.945,0.567,0.503,
        0.842,0.24; 0.892,1.892,0.946,0.568,0.502,0.843,0.241; 0.894,1.894,
        0.947,0.568,0.502,0.844,0.241; 0.896,1.896,0.948,0.569,0.501,0.845,
        0.241; 0.898,1.898,0.949,0.569,0.501,0.846,0.241; 0.9,1.9,0.95,0.57,0.5,
        0.847,0.242; 0.902,1.902,0.951,0.571,0.499,0.848,0.242; 0.904,1.904,
        0.952,0.571,0.499,0.849,0.242; 0.906,1.906,0.953,0.572,0.498,0.85,0.242;
        0.908,1.908,0.954,0.572,0.498,0.85,0.243; 0.91,1.91,0.955,0.573,0.497,
        0.851,0.243; 0.912,1.912,0.956,0.574,0.497,0.852,0.243; 0.914,1.914,
        0.957,0.574,0.496,0.853,0.243; 0.916,1.916,0.958,0.575,0.496,0.854,
        0.244; 0.918,1.918,0.959,0.575,0.495,0.855,0.244; 0.92,1.92,0.96,0.576,
        0.495,0.856,0.244; 0.922,1.922,0.961,0.577,0.494,0.857,0.244; 0.924,
        1.924,0.962,0.577,0.494,0.858,0.245; 0.926,1.926,0.963,0.578,0.493,
        0.858,0.245; 0.928,1.928,0.964,0.578,0.493,0.859,0.245; 0.93,1.93,0.965,
        0.579,0.492,0.86,0.245; 0.932,1.932,0.966,0.58,0.492,0.861,0.246; 0.934,
        1.934,0.967,0.58,0.491,0.862,0.246; 0.936,1.936,0.968,0.581,0.491,0.863,
        0.246; 0.938,1.938,0.969,0.581,0.49,0.864,0.246; 0.94,1.94,0.97,0.582,
        0.49,0.865,0.247; 0.942,1.942,0.971,0.583,0.489,0.866,0.247; 0.944,
        1.944,0.972,0.583,0.489,0.866,0.247; 0.946,1.946,0.973,0.584,0.488,
        0.867,0.247; 0.948,1.948,0.974,0.584,0.488,0.868,0.248; 0.95,1.95,0.975,
        0.585,0.487,0.869,0.248; 0.952,1.952,0.976,0.586,0.487,0.87,0.248;
        0.954,1.954,0.977,0.586,0.486,0.871,0.248; 0.956,1.956,0.978,0.587,
        0.486,0.872,0.249; 0.958,1.958,0.979,0.587,0.485,0.873,0.249; 0.96,1.96,
        0.98,0.588,0.485,0.874,0.249; 0.962,1.962,0.981,0.589,0.484,0.874,0.249;
        0.964,1.964,0.982,0.589,0.484,0.875,0.25; 0.966,1.966,0.983,0.59,0.483,
        0.876,0.25; 0.968,1.968,0.984,0.59,0.483,0.877,0.25; 0.97,1.97,0.985,
        0.591,0.482,0.878,0.25; 0.972,1.972,0.986,0.592,0.482,0.879,0.251;
        0.974,1.974,0.987,0.592,0.481,0.88,0.251; 0.976,1.976,0.988,0.593,0.481,
        0.881,0.251; 0.978,1.978,0.989,0.593,0.48,0.882,0.251; 0.98,1.98,0.99,
        0.594,0.48,0.883,0.252; 0.982,1.982,0.991,0.595,0.479,0.883,0.252;
        0.984,1.984,0.992,0.595,0.479,0.884,0.252; 0.986,1.986,0.993,0.596,
        0.478,0.885,0.252; 0.988,1.988,0.994,0.596,0.478,0.886,0.253; 0.99,1.99,
        0.995,0.597,0.477,0.887,0.253; 0.992,1.992,0.996,0.598,0.477,0.888,
        0.253; 0.994,1.994,0.997,0.598,0.476,0.889,0.253; 0.996,1.996,0.998,
        0.599,0.476,0.89,0.254; 0.998,1.998,0.999,0.599,0.475,0.891,0.254; 1,2,
        1,0.6,0.475,0.891,0.254; 1,2,1,0.6,0.475,0.891,0.254], extrapolation=
        Buildings.Controls.OBC.CDL.Types.Extrapolation.HoldLastPoint)
    "Data for validating the PIDGain block"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(ReferenceData.y[1], pIDGain.kp) annotation (Line(points={{-38,0},{-20,
          0},{-20,6},{-12,6}}, color={0,0,127}));
  connect(pIDGain.T, ReferenceData.y[2])
    annotation (Line(points={{-12,0},{-38,0}}, color={0,0,127}));
  connect(pIDGain.L, ReferenceData.y[3]) annotation (Line(points={{-12,-6},{-20,
          -6},{-20,0},{-38,0}}, color={0,0,127}));
  annotation (
      experiment(
      StopTime=1.0,
      Tolerance=1e-06),
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/Utilities/PIDWithAutotuning/AutoTuner/AMIGO/Validation/PIDGain.mos" "Simulate and plot"),
    Icon(
      coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}),
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
June 1, 2022, by Sen Huang:<br/>
First implementation<br/>
</li>
</ul>
</html>", info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Controls.OBC.Utilities.PIDWithAutotuning.AutoTuner.AMIGO.PIDGain\">
Buildings.Controls.OBC.Utilities.PIDWithAutotuning.AutoTuner.AMIGO.PIDGain</a>.
</p>
<p>
The reference data is imported from a raw data that is generated with a Python implementation of this block.
</p>
</html>"));
end PIDGain;
