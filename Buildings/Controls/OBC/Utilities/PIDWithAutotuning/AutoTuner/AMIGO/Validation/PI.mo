within Buildings.Controls.OBC.Utilities.PIDWithAutotuning.AutoTuner.Amigo.Validation;
model PI "Test model for PI"
  Buildings.Controls.OBC.Utilities.PIDWithAutotuning.AutoTuner.Amigo.PI pI
    "Calculate the parameters for a PI controller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable ReferenceData(table=[0,1,0.5,0.3,0.343,0.469;
        0.002,1.002,0.501,0.301,0.342,0.47; 0.004,1.004,0.502,0.301,0.341,0.471;
        0.006,1.006,0.503,0.302,0.341,0.472; 0.008,1.008,0.504,0.302,0.34,0.473;
        0.01,1.01,0.505,0.303,0.339,0.473; 0.012,1.012,0.506,0.304,0.339,0.474;
        0.014,1.014,0.507,0.304,0.338,0.475; 0.016,1.016,0.508,0.305,0.337,
        0.476; 0.018,1.018,0.509,0.305,0.337,0.477; 0.02,1.02,0.51,0.306,0.336,
        0.478; 0.022,1.022,0.511,0.307,0.335,0.479; 0.024,1.024,0.512,0.307,
        0.335,0.48; 0.026,1.026,0.513,0.308,0.334,0.481; 0.028,1.028,0.514,
        0.308,0.333,0.482; 0.03,1.03,0.515,0.309,0.333,0.483; 0.032,1.032,0.516,
        0.31,0.332,0.484; 0.034,1.034,0.517,0.31,0.331,0.485; 0.036,1.036,0.518,
        0.311,0.331,0.486; 0.038,1.038,0.519,0.311,0.33,0.487; 0.04,1.04,0.52,
        0.312,0.33,0.488; 0.042,1.042,0.521,0.313,0.329,0.488; 0.044,1.044,
        0.522,0.313,0.328,0.489; 0.046,1.046,0.523,0.314,0.328,0.49; 0.048,
        1.048,0.524,0.314,0.327,0.491; 0.05,1.05,0.525,0.315,0.326,0.492; 0.052,
        1.052,0.526,0.316,0.326,0.493; 0.054,1.054,0.527,0.316,0.325,0.494;
        0.056,1.056,0.528,0.317,0.325,0.495; 0.058,1.058,0.529,0.317,0.324,
        0.496; 0.06,1.06,0.53,0.318,0.323,0.497; 0.062,1.062,0.531,0.319,0.323,
        0.498; 0.064,1.064,0.532,0.319,0.322,0.499; 0.066,1.066,0.533,0.32,
        0.321,0.5; 0.068,1.068,0.534,0.32,0.321,0.501; 0.07,1.07,0.535,0.321,
        0.32,0.502; 0.072,1.072,0.536,0.322,0.32,0.503; 0.074,1.074,0.537,0.322,
        0.319,0.503; 0.076,1.076,0.538,0.323,0.319,0.504; 0.078,1.078,0.539,
        0.323,0.318,0.505; 0.08,1.08,0.54,0.324,0.317,0.506; 0.082,1.082,0.541,
        0.325,0.317,0.507; 0.084,1.084,0.542,0.325,0.316,0.508; 0.086,1.086,
        0.543,0.326,0.316,0.509; 0.088,1.088,0.544,0.326,0.315,0.51; 0.09,1.09,
        0.545,0.327,0.314,0.511; 0.092,1.092,0.546,0.328,0.314,0.512; 0.094,
        1.094,0.547,0.328,0.313,0.513; 0.096,1.096,0.548,0.329,0.313,0.514;
        0.098,1.098,0.549,0.329,0.312,0.515; 0.1,1.1,0.55,0.33,0.312,0.516;
        0.102,1.102,0.551,0.331,0.311,0.517; 0.104,1.104,0.552,0.331,0.31,0.518;
        0.106,1.106,0.553,0.332,0.31,0.518; 0.108,1.108,0.554,0.332,0.309,0.519;
        0.11,1.11,0.555,0.333,0.309,0.52; 0.112,1.112,0.556,0.334,0.308,0.521;
        0.114,1.114,0.557,0.334,0.308,0.522; 0.116,1.116,0.558,0.335,0.307,
        0.523; 0.118,1.118,0.559,0.335,0.307,0.524; 0.12,1.12,0.56,0.336,0.306,
        0.525; 0.122,1.122,0.561,0.337,0.305,0.526; 0.124,1.124,0.562,0.337,
        0.305,0.527; 0.126,1.126,0.563,0.338,0.304,0.528; 0.128,1.128,0.564,
        0.338,0.304,0.529; 0.13,1.13,0.565,0.339,0.303,0.53; 0.132,1.132,0.566,
        0.34,0.303,0.531; 0.134,1.134,0.567,0.34,0.302,0.532; 0.136,1.136,0.568,
        0.341,0.302,0.533; 0.138,1.138,0.569,0.341,0.301,0.534; 0.14,1.14,0.57,
        0.342,0.301,0.534; 0.142,1.142,0.571,0.343,0.3,0.535; 0.144,1.144,0.572,
        0.343,0.3,0.536; 0.146,1.146,0.573,0.344,0.299,0.537; 0.148,1.148,0.574,
        0.344,0.299,0.538; 0.15,1.15,0.575,0.345,0.298,0.539; 0.152,1.152,0.576,
        0.346,0.297,0.54; 0.154,1.154,0.577,0.346,0.297,0.541; 0.156,1.156,
        0.578,0.347,0.296,0.542; 0.158,1.158,0.579,0.347,0.296,0.543; 0.16,1.16,
        0.58,0.348,0.295,0.544; 0.162,1.162,0.581,0.349,0.295,0.545; 0.164,
        1.164,0.582,0.349,0.294,0.546; 0.166,1.166,0.583,0.35,0.294,0.547;
        0.168,1.168,0.584,0.35,0.293,0.548; 0.17,1.17,0.585,0.351,0.293,0.549;
        0.172,1.172,0.586,0.352,0.292,0.549; 0.174,1.174,0.587,0.352,0.292,0.55;
        0.176,1.176,0.588,0.353,0.291,0.551; 0.178,1.178,0.589,0.353,0.291,
        0.552; 0.18,1.18,0.59,0.354,0.29,0.553; 0.182,1.182,0.591,0.355,0.29,
        0.554; 0.184,1.184,0.592,0.355,0.289,0.555; 0.186,1.186,0.593,0.356,
        0.289,0.556; 0.188,1.188,0.594,0.356,0.288,0.557; 0.19,1.19,0.595,0.357,
        0.288,0.558; 0.192,1.192,0.596,0.358,0.288,0.559; 0.194,1.194,0.597,
        0.358,0.287,0.56; 0.196,1.196,0.598,0.359,0.287,0.561; 0.198,1.198,
        0.599,0.359,0.286,0.562; 0.2,1.2,0.6,0.36,0.286,0.563; 0.202,1.202,
        0.601,0.361,0.285,0.564; 0.204,1.204,0.602,0.361,0.285,0.564; 0.206,
        1.206,0.603,0.362,0.284,0.565; 0.208,1.208,0.604,0.362,0.284,0.566;
        0.21,1.21,0.605,0.363,0.283,0.567; 0.212,1.212,0.606,0.364,0.283,0.568;
        0.214,1.214,0.607,0.364,0.282,0.569; 0.216,1.216,0.608,0.365,0.282,0.57;
        0.218,1.218,0.609,0.365,0.281,0.571; 0.22,1.22,0.61,0.366,0.281,0.572;
        0.222,1.222,0.611,0.367,0.28,0.573; 0.224,1.224,0.612,0.367,0.28,0.574;
        0.226,1.226,0.613,0.368,0.28,0.575; 0.228,1.228,0.614,0.368,0.279,0.576;
        0.23,1.23,0.615,0.369,0.279,0.577; 0.232,1.232,0.616,0.37,0.278,0.578;
        0.234,1.234,0.617,0.37,0.278,0.579; 0.236,1.236,0.618,0.371,0.277,0.579;
        0.238,1.238,0.619,0.371,0.277,0.58; 0.24,1.24,0.62,0.372,0.276,0.581;
        0.242,1.242,0.621,0.373,0.276,0.582; 0.244,1.244,0.622,0.373,0.275,
        0.583; 0.246,1.246,0.623,0.374,0.275,0.584; 0.248,1.248,0.624,0.374,
        0.275,0.585; 0.25,1.25,0.625,0.375,0.274,0.586; 0.252,1.252,0.626,0.376,
        0.274,0.587; 0.254,1.254,0.627,0.376,0.273,0.588; 0.256,1.256,0.628,
        0.377,0.273,0.589; 0.258,1.258,0.629,0.377,0.272,0.59; 0.26,1.26,0.63,
        0.378,0.272,0.591; 0.262,1.262,0.631,0.379,0.272,0.592; 0.264,1.264,
        0.632,0.379,0.271,0.593; 0.266,1.266,0.633,0.38,0.271,0.594; 0.268,
        1.268,0.634,0.38,0.27,0.594; 0.27,1.27,0.635,0.381,0.27,0.595; 0.272,
        1.272,0.636,0.382,0.269,0.596; 0.274,1.274,0.637,0.382,0.269,0.597;
        0.276,1.276,0.638,0.383,0.269,0.598; 0.278,1.278,0.639,0.383,0.268,
        0.599; 0.28,1.28,0.64,0.384,0.268,0.6; 0.282,1.282,0.641,0.385,0.267,
        0.601; 0.284,1.284,0.642,0.385,0.267,0.602; 0.286,1.286,0.643,0.386,
        0.266,0.603; 0.288,1.288,0.644,0.386,0.266,0.604; 0.29,1.29,0.645,0.387,
        0.266,0.605; 0.292,1.292,0.646,0.388,0.265,0.606; 0.294,1.294,0.647,
        0.388,0.265,0.607; 0.296,1.296,0.648,0.389,0.264,0.608; 0.298,1.298,
        0.649,0.389,0.264,0.609; 0.3,1.3,0.65,0.39,0.264,0.609; 0.302,1.302,
        0.651,0.391,0.263,0.61; 0.304,1.304,0.652,0.391,0.263,0.611; 0.306,
        1.306,0.653,0.392,0.262,0.612; 0.308,1.308,0.654,0.392,0.262,0.613;
        0.31,1.31,0.655,0.393,0.262,0.614; 0.312,1.312,0.656,0.394,0.261,0.615;
        0.314,1.314,0.657,0.394,0.261,0.616; 0.316,1.316,0.658,0.395,0.26,0.617;
        0.318,1.318,0.659,0.395,0.26,0.618; 0.32,1.32,0.66,0.396,0.26,0.619;
        0.322,1.322,0.661,0.397,0.259,0.62; 0.324,1.324,0.662,0.397,0.259,0.621;
        0.326,1.326,0.663,0.398,0.258,0.622; 0.328,1.328,0.664,0.398,0.258,
        0.623; 0.33,1.33,0.665,0.399,0.258,0.624; 0.332,1.332,0.666,0.4,0.257,
        0.624; 0.334,1.334,0.667,0.4,0.257,0.625; 0.336,1.336,0.668,0.401,0.257,
        0.626; 0.338,1.338,0.669,0.401,0.256,0.627; 0.34,1.34,0.67,0.402,0.256,
        0.628; 0.342,1.342,0.671,0.403,0.255,0.629; 0.344,1.344,0.672,0.403,
        0.255,0.63; 0.346,1.346,0.673,0.404,0.255,0.631; 0.348,1.348,0.674,
        0.404,0.254,0.632; 0.35,1.35,0.675,0.405,0.254,0.633; 0.352,1.352,0.676,
        0.406,0.253,0.634; 0.354,1.354,0.677,0.406,0.253,0.635; 0.356,1.356,
        0.678,0.407,0.253,0.636; 0.358,1.358,0.679,0.407,0.252,0.637; 0.36,1.36,
        0.68,0.408,0.252,0.638; 0.362,1.362,0.681,0.409,0.252,0.639; 0.364,
        1.364,0.682,0.409,0.251,0.639; 0.366,1.366,0.683,0.41,0.251,0.64; 0.368,
        1.368,0.684,0.41,0.251,0.641; 0.37,1.37,0.685,0.411,0.25,0.642; 0.372,
        1.372,0.686,0.412,0.25,0.643; 0.374,1.374,0.687,0.412,0.249,0.644;
        0.376,1.376,0.688,0.413,0.249,0.645; 0.378,1.378,0.689,0.413,0.249,
        0.646; 0.38,1.38,0.69,0.414,0.248,0.647; 0.382,1.382,0.691,0.415,0.248,
        0.648; 0.384,1.384,0.692,0.415,0.248,0.649; 0.386,1.386,0.693,0.416,
        0.247,0.65; 0.388,1.388,0.694,0.416,0.247,0.651; 0.39,1.39,0.695,0.417,
        0.247,0.652; 0.392,1.392,0.696,0.418,0.246,0.653; 0.394,1.394,0.697,
        0.418,0.246,0.654; 0.396,1.396,0.698,0.419,0.245,0.654; 0.398,1.398,
        0.699,0.419,0.245,0.655; 0.4,1.4,0.7,0.42,0.245,0.656; 0.402,1.402,
        0.701,0.421,0.244,0.657; 0.404,1.404,0.702,0.421,0.244,0.658; 0.406,
        1.406,0.703,0.422,0.244,0.659; 0.408,1.408,0.704,0.422,0.243,0.66; 0.41,
        1.41,0.705,0.423,0.243,0.661; 0.412,1.412,0.706,0.424,0.243,0.662;
        0.414,1.414,0.707,0.424,0.242,0.663; 0.416,1.416,0.708,0.425,0.242,
        0.664; 0.418,1.418,0.709,0.425,0.242,0.665; 0.42,1.42,0.71,0.426,0.241,
        0.666; 0.422,1.422,0.711,0.427,0.241,0.667; 0.424,1.424,0.712,0.427,
        0.241,0.668; 0.426,1.426,0.713,0.428,0.24,0.669; 0.428,1.428,0.714,
        0.428,0.24,0.669; 0.43,1.43,0.715,0.429,0.24,0.67; 0.432,1.432,0.716,
        0.43,0.239,0.671; 0.434,1.434,0.717,0.43,0.239,0.672; 0.436,1.436,0.718,
        0.431,0.239,0.673; 0.438,1.438,0.719,0.431,0.238,0.674; 0.44,1.44,0.72,
        0.432,0.238,0.675; 0.442,1.442,0.721,0.433,0.238,0.676; 0.444,1.444,
        0.722,0.433,0.237,0.677; 0.446,1.446,0.723,0.434,0.237,0.678; 0.448,
        1.448,0.724,0.434,0.237,0.679; 0.45,1.45,0.725,0.435,0.236,0.68; 0.452,
        1.452,0.726,0.436,0.236,0.681; 0.454,1.454,0.727,0.436,0.236,0.682;
        0.456,1.456,0.728,0.437,0.235,0.683; 0.458,1.458,0.729,0.437,0.235,
        0.684; 0.46,1.46,0.73,0.438,0.235,0.684; 0.462,1.462,0.731,0.439,0.234,
        0.685; 0.464,1.464,0.732,0.439,0.234,0.686; 0.466,1.466,0.733,0.44,
        0.234,0.687; 0.468,1.468,0.734,0.44,0.233,0.688; 0.47,1.47,0.735,0.441,
        0.233,0.689; 0.472,1.472,0.736,0.442,0.233,0.69; 0.474,1.474,0.737,
        0.442,0.233,0.691; 0.476,1.476,0.738,0.443,0.232,0.692; 0.478,1.478,
        0.739,0.443,0.232,0.693; 0.48,1.48,0.74,0.444,0.232,0.694; 0.482,1.482,
        0.741,0.445,0.231,0.695; 0.484,1.484,0.742,0.445,0.231,0.696; 0.486,
        1.486,0.743,0.446,0.231,0.697; 0.488,1.488,0.744,0.446,0.23,0.698; 0.49,
        1.49,0.745,0.447,0.23,0.699; 0.492,1.492,0.746,0.448,0.23,0.699; 0.494,
        1.494,0.747,0.448,0.229,0.7; 0.496,1.496,0.748,0.449,0.229,0.701; 0.498,
        1.498,0.749,0.449,0.229,0.702; 0.5,1.5,0.75,0.45,0.228,0.703; 0.502,
        1.502,0.751,0.451,0.228,0.704; 0.504,1.504,0.752,0.451,0.228,0.705;
        0.506,1.506,0.753,0.452,0.228,0.706; 0.508,1.508,0.754,0.452,0.227,
        0.707; 0.51,1.51,0.755,0.453,0.227,0.708; 0.512,1.512,0.756,0.454,0.227,
        0.709; 0.514,1.514,0.757,0.454,0.226,0.71; 0.516,1.516,0.758,0.455,
        0.226,0.711; 0.518,1.518,0.759,0.455,0.226,0.712; 0.52,1.52,0.76,0.456,
        0.225,0.713; 0.522,1.522,0.761,0.457,0.225,0.714; 0.524,1.524,0.762,
        0.457,0.225,0.714; 0.526,1.526,0.763,0.458,0.225,0.715; 0.528,1.528,
        0.764,0.458,0.224,0.716; 0.53,1.53,0.765,0.459,0.224,0.717; 0.532,1.532,
        0.766,0.46,0.224,0.718; 0.534,1.534,0.767,0.46,0.223,0.719; 0.536,1.536,
        0.768,0.461,0.223,0.72; 0.538,1.538,0.769,0.461,0.223,0.721; 0.54,1.54,
        0.77,0.462,0.223,0.722; 0.542,1.542,0.771,0.463,0.222,0.723; 0.544,
        1.544,0.772,0.463,0.222,0.724; 0.546,1.546,0.773,0.464,0.222,0.725;
        0.548,1.548,0.774,0.464,0.221,0.726; 0.55,1.55,0.775,0.465,0.221,0.727;
        0.552,1.552,0.776,0.466,0.221,0.728; 0.554,1.554,0.777,0.466,0.221,
        0.729; 0.556,1.556,0.778,0.467,0.22,0.729; 0.558,1.558,0.779,0.467,0.22,
        0.73; 0.56,1.56,0.78,0.468,0.22,0.731; 0.562,1.562,0.781,0.469,0.219,
        0.732; 0.564,1.564,0.782,0.469,0.219,0.733; 0.566,1.566,0.783,0.47,
        0.219,0.734; 0.568,1.568,0.784,0.47,0.219,0.735; 0.57,1.57,0.785,0.471,
        0.218,0.736; 0.572,1.572,0.786,0.472,0.218,0.737; 0.574,1.574,0.787,
        0.472,0.218,0.738; 0.576,1.576,0.788,0.473,0.217,0.739; 0.578,1.578,
        0.789,0.473,0.217,0.74; 0.58,1.58,0.79,0.474,0.217,0.741; 0.582,1.582,
        0.791,0.475,0.217,0.742; 0.584,1.584,0.792,0.475,0.216,0.743; 0.586,
        1.586,0.793,0.476,0.216,0.744; 0.588,1.588,0.794,0.476,0.216,0.744;
        0.59,1.59,0.795,0.477,0.216,0.745; 0.592,1.592,0.796,0.478,0.215,0.746;
        0.594,1.594,0.797,0.478,0.215,0.747; 0.596,1.596,0.798,0.479,0.215,
        0.748; 0.598,1.598,0.799,0.479,0.214,0.749; 0.6,1.6,0.8,0.48,0.214,0.75;
        0.602,1.602,0.801,0.481,0.214,0.751; 0.604,1.604,0.802,0.481,0.214,
        0.752; 0.606,1.606,0.803,0.482,0.213,0.753; 0.608,1.608,0.804,0.482,
        0.213,0.754; 0.61,1.61,0.805,0.483,0.213,0.755; 0.612,1.612,0.806,0.484,
        0.213,0.756; 0.614,1.614,0.807,0.484,0.212,0.757; 0.616,1.616,0.808,
        0.485,0.212,0.758; 0.618,1.618,0.809,0.485,0.212,0.759; 0.62,1.62,0.81,
        0.486,0.212,0.759; 0.622,1.622,0.811,0.487,0.211,0.76; 0.624,1.624,
        0.812,0.487,0.211,0.761; 0.626,1.626,0.813,0.488,0.211,0.762; 0.628,
        1.628,0.814,0.488,0.211,0.763; 0.63,1.63,0.815,0.489,0.21,0.764; 0.632,
        1.632,0.816,0.49,0.21,0.765; 0.634,1.634,0.817,0.49,0.21,0.766; 0.636,
        1.636,0.818,0.491,0.209,0.767; 0.638,1.638,0.819,0.491,0.209,0.768;
        0.64,1.64,0.82,0.492,0.209,0.769; 0.642,1.642,0.821,0.493,0.209,0.77;
        0.644,1.644,0.822,0.493,0.208,0.771; 0.646,1.646,0.823,0.494,0.208,
        0.772; 0.648,1.648,0.824,0.494,0.208,0.773; 0.65,1.65,0.825,0.495,0.208,
        0.774; 0.652,1.652,0.826,0.496,0.207,0.774; 0.654,1.654,0.827,0.496,
        0.207,0.775; 0.656,1.656,0.828,0.497,0.207,0.776; 0.658,1.658,0.829,
        0.497,0.207,0.777; 0.66,1.66,0.83,0.498,0.206,0.778; 0.662,1.662,0.831,
        0.499,0.206,0.779; 0.664,1.664,0.832,0.499,0.206,0.78; 0.666,1.666,
        0.833,0.5,0.206,0.781; 0.668,1.668,0.834,0.5,0.205,0.782; 0.67,1.67,
        0.835,0.501,0.205,0.783; 0.672,1.672,0.836,0.502,0.205,0.784; 0.674,
        1.674,0.837,0.502,0.205,0.785; 0.676,1.676,0.838,0.503,0.204,0.786;
        0.678,1.678,0.839,0.503,0.204,0.787; 0.68,1.68,0.84,0.504,0.204,0.788;
        0.682,1.682,0.841,0.505,0.204,0.789; 0.684,1.684,0.842,0.505,0.204,
        0.789; 0.686,1.686,0.843,0.506,0.203,0.79; 0.688,1.688,0.844,0.506,
        0.203,0.791; 0.69,1.69,0.845,0.507,0.203,0.792; 0.692,1.692,0.846,0.508,
        0.203,0.793; 0.694,1.694,0.847,0.508,0.202,0.794; 0.696,1.696,0.848,
        0.509,0.202,0.795; 0.698,1.698,0.849,0.509,0.202,0.796; 0.7,1.7,0.85,
        0.51,0.202,0.797; 0.702,1.702,0.851,0.511,0.201,0.798; 0.704,1.704,
        0.852,0.511,0.201,0.799; 0.706,1.706,0.853,0.512,0.201,0.8; 0.708,1.708,
        0.854,0.512,0.201,0.801; 0.71,1.71,0.855,0.513,0.2,0.802; 0.712,1.712,
        0.856,0.514,0.2,0.803; 0.714,1.714,0.857,0.514,0.2,0.804; 0.716,1.716,
        0.858,0.515,0.2,0.804; 0.718,1.718,0.859,0.515,0.199,0.805; 0.72,1.72,
        0.86,0.516,0.199,0.806; 0.722,1.722,0.861,0.517,0.199,0.807; 0.724,
        1.724,0.862,0.517,0.199,0.808; 0.726,1.726,0.863,0.518,0.199,0.809;
        0.728,1.728,0.864,0.518,0.198,0.81; 0.73,1.73,0.865,0.519,0.198,0.811;
        0.732,1.732,0.866,0.52,0.198,0.812; 0.734,1.734,0.867,0.52,0.198,0.813;
        0.736,1.736,0.868,0.521,0.197,0.814; 0.738,1.738,0.869,0.521,0.197,
        0.815; 0.74,1.74,0.87,0.522,0.197,0.816; 0.742,1.742,0.871,0.523,0.197,
        0.817; 0.744,1.744,0.872,0.523,0.197,0.818; 0.746,1.746,0.873,0.524,
        0.196,0.819; 0.748,1.748,0.874,0.524,0.196,0.819; 0.75,1.75,0.875,0.525,
        0.196,0.82; 0.752,1.752,0.876,0.526,0.196,0.821; 0.754,1.754,0.877,
        0.526,0.195,0.822; 0.756,1.756,0.878,0.527,0.195,0.823; 0.758,1.758,
        0.879,0.527,0.195,0.824; 0.76,1.76,0.88,0.528,0.195,0.825; 0.762,1.762,
        0.881,0.529,0.194,0.826; 0.764,1.764,0.882,0.529,0.194,0.827; 0.766,
        1.766,0.883,0.53,0.194,0.828; 0.768,1.768,0.884,0.53,0.194,0.829; 0.77,
        1.77,0.885,0.531,0.194,0.83; 0.772,1.772,0.886,0.532,0.193,0.831; 0.774,
        1.774,0.887,0.532,0.193,0.832; 0.776,1.776,0.888,0.533,0.193,0.833;
        0.778,1.778,0.889,0.533,0.193,0.834; 0.78,1.78,0.89,0.534,0.193,0.834;
        0.782,1.782,0.891,0.535,0.192,0.835; 0.784,1.784,0.892,0.535,0.192,
        0.836; 0.786,1.786,0.893,0.536,0.192,0.837; 0.788,1.788,0.894,0.536,
        0.192,0.838; 0.79,1.79,0.895,0.537,0.191,0.839; 0.792,1.792,0.896,0.538,
        0.191,0.84; 0.794,1.794,0.897,0.538,0.191,0.841; 0.796,1.796,0.898,
        0.539,0.191,0.842; 0.798,1.798,0.899,0.539,0.191,0.843; 0.8,1.8,0.9,
        0.54,0.19,0.844; 0.802,1.802,0.901,0.541,0.19,0.845; 0.804,1.804,0.902,
        0.541,0.19,0.846; 0.806,1.806,0.903,0.542,0.19,0.847; 0.808,1.808,0.904,
        0.542,0.19,0.848; 0.81,1.81,0.905,0.543,0.189,0.849; 0.812,1.812,0.906,
        0.544,0.189,0.849; 0.814,1.814,0.907,0.544,0.189,0.85; 0.816,1.816,
        0.908,0.545,0.189,0.851; 0.818,1.818,0.909,0.545,0.189,0.852; 0.82,1.82,
        0.91,0.546,0.188,0.853; 0.822,1.822,0.911,0.547,0.188,0.854; 0.824,
        1.824,0.912,0.547,0.188,0.855; 0.826,1.826,0.913,0.548,0.188,0.856;
        0.828,1.828,0.914,0.548,0.187,0.857; 0.83,1.83,0.915,0.549,0.187,0.858;
        0.832,1.832,0.916,0.55,0.187,0.859; 0.834,1.834,0.917,0.55,0.187,0.86;
        0.836,1.836,0.918,0.551,0.187,0.861; 0.838,1.838,0.919,0.551,0.186,
        0.862; 0.84,1.84,0.92,0.552,0.186,0.863; 0.842,1.842,0.921,0.553,0.186,
        0.864; 0.844,1.844,0.922,0.553,0.186,0.864; 0.846,1.846,0.923,0.554,
        0.186,0.865; 0.848,1.848,0.924,0.554,0.185,0.866; 0.85,1.85,0.925,0.555,
        0.185,0.867; 0.852,1.852,0.926,0.556,0.185,0.868; 0.854,1.854,0.927,
        0.556,0.185,0.869; 0.856,1.856,0.928,0.557,0.185,0.87; 0.858,1.858,
        0.929,0.557,0.184,0.871; 0.86,1.86,0.93,0.558,0.184,0.872; 0.862,1.862,
        0.931,0.559,0.184,0.873; 0.864,1.864,0.932,0.559,0.184,0.874; 0.866,
        1.866,0.933,0.56,0.184,0.875; 0.868,1.868,0.934,0.56,0.183,0.876; 0.87,
        1.87,0.935,0.561,0.183,0.877; 0.872,1.872,0.936,0.562,0.183,0.878;
        0.874,1.874,0.937,0.562,0.183,0.879; 0.876,1.876,0.938,0.563,0.183,
        0.879; 0.878,1.878,0.939,0.563,0.182,0.88; 0.88,1.88,0.94,0.564,0.182,
        0.881; 0.882,1.882,0.941,0.565,0.182,0.882; 0.884,1.884,0.942,0.565,
        0.182,0.883; 0.886,1.886,0.943,0.566,0.182,0.884; 0.888,1.888,0.944,
        0.566,0.182,0.885; 0.89,1.89,0.945,0.567,0.181,0.886; 0.892,1.892,0.946,
        0.568,0.181,0.887; 0.894,1.894,0.947,0.568,0.181,0.888; 0.896,1.896,
        0.948,0.569,0.181,0.889; 0.898,1.898,0.949,0.569,0.181,0.89; 0.9,1.9,
        0.95,0.57,0.18,0.891; 0.902,1.902,0.951,0.571,0.18,0.892; 0.904,1.904,
        0.952,0.571,0.18,0.893; 0.906,1.906,0.953,0.572,0.18,0.894; 0.908,1.908,
        0.954,0.572,0.18,0.894; 0.91,1.91,0.955,0.573,0.179,0.895; 0.912,1.912,
        0.956,0.574,0.179,0.896; 0.914,1.914,0.957,0.574,0.179,0.897; 0.916,
        1.916,0.958,0.575,0.179,0.898; 0.918,1.918,0.959,0.575,0.179,0.899;
        0.92,1.92,0.96,0.576,0.178,0.9; 0.922,1.922,0.961,0.577,0.178,0.901;
        0.924,1.924,0.962,0.577,0.178,0.902; 0.926,1.926,0.963,0.578,0.178,
        0.903; 0.928,1.928,0.964,0.578,0.178,0.904; 0.93,1.93,0.965,0.579,0.178,
        0.905; 0.932,1.932,0.966,0.58,0.177,0.906; 0.934,1.934,0.967,0.58,0.177,
        0.907; 0.936,1.936,0.968,0.581,0.177,0.908; 0.938,1.938,0.969,0.581,
        0.177,0.909; 0.94,1.94,0.97,0.582,0.177,0.909; 0.942,1.942,0.971,0.583,
        0.176,0.91; 0.944,1.944,0.972,0.583,0.176,0.911; 0.946,1.946,0.973,
        0.584,0.176,0.912; 0.948,1.948,0.974,0.584,0.176,0.913; 0.95,1.95,0.975,
        0.585,0.176,0.914; 0.952,1.952,0.976,0.586,0.176,0.915; 0.954,1.954,
        0.977,0.586,0.175,0.916; 0.956,1.956,0.978,0.587,0.175,0.917; 0.958,
        1.958,0.979,0.587,0.175,0.918; 0.96,1.96,0.98,0.588,0.175,0.919; 0.962,
        1.962,0.981,0.589,0.175,0.92; 0.964,1.964,0.982,0.589,0.174,0.921;
        0.966,1.966,0.983,0.59,0.174,0.922; 0.968,1.968,0.984,0.59,0.174,0.923;
        0.97,1.97,0.985,0.591,0.174,0.924; 0.972,1.972,0.986,0.592,0.174,0.924;
        0.974,1.974,0.987,0.592,0.174,0.925; 0.976,1.976,0.988,0.593,0.173,
        0.926; 0.978,1.978,0.989,0.593,0.173,0.927; 0.98,1.98,0.99,0.594,0.173,
        0.928; 0.982,1.982,0.991,0.595,0.173,0.929; 0.984,1.984,0.992,0.595,
        0.173,0.93; 0.986,1.986,0.993,0.596,0.173,0.931; 0.988,1.988,0.994,
        0.596,0.172,0.932; 0.99,1.99,0.995,0.597,0.172,0.933; 0.992,1.992,0.996,
        0.598,0.172,0.934; 0.994,1.994,0.997,0.598,0.172,0.935; 0.996,1.996,
        0.998,0.599,0.172,0.936; 0.998,1.998,0.999,0.599,0.172,0.937; 1,2,1,0.6,
        0.171,0.938; 1,2,1,0.6,0.171,0.938], extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.HoldLastPoint)
    "Data for validating the PI block"
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
equation
  connect(ReferenceData.y[1], pI.kp) annotation (Line(points={{-36,0},{-20,0},{
          -20,6},{-12,6}}, color={0,0,127}));
  connect(pI.T, ReferenceData.y[2])
    annotation (Line(points={{-12,0},{-36,0}}, color={0,0,127}));
  connect(pI.L, ReferenceData.y[3]) annotation (Line(points={{-12,-6},{-20,-6},
          {-20,0},{-36,0}}, color={0,0,127}));
  annotation (
      experiment(
      StopTime=1.0,
      Tolerance=1e-06),
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/Utilities/PIDWithAutotuning/AutoTuner/AMIGO/Validation/PI.mos" "Simulate and plot"),
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
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
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
<a href=\"modelica://Buildings.Controls.OBC.Utilities.PIDWithAutotuning.AutoTuner.AMIGO.PI\">
Buildings.Controls.OBC.Utilities.PIDWithAutotuning.AutoTuner.AMIGO.PI</a>.
</p>
<p>
The reference data is imported from a raw data that is generated with a Python implementation of this block.
</p>
</html>"));
end PI;
