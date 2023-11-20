function net = ANFISnet(Qin, MFQin, Qout, MFRQout, Mand, Mor, MlinkandQinMand, MlinkorMandMor)

    % Проверка корректности входных данных
    if size(MFQin, 1) ~= Qin || size(MFQin, 2) ~= Mand
        error('Размер матрицы функций принадлежности первого слоя должен быть %d x %d', Qin, Mand);
    end
    
    if size(MFRQout, 1) ~= Qout || size(MFRQout, 2) ~= Mor
        error('Размер матрицы функций принадлежности выходного слоя должен быть %d x %d', Qout, Mor);
    end

    if size(MlinkandQinMand, 1) ~= Qin || size(MlinkandQinMand, 2)  ~= Mand
        error('Размер матрицы связей Qin входов и Mand нейронов должен быть %d x %d', Qin, Mand);
    end

    if size(MlinkorMandMor, 1) ~= Mand || size(MlinkorMandMor, 2)  ~= Mor
        error('Размер матрицы связей Mand выходов И-нейронов и Mor ИЛИ-нейронов должен быть %d x %d', Mand, Mor);
    end

    % Создаем структуру для хранения параметров нейронной сети
    % первый слой
    net.Qin = Qin; % количество входов сети
    net.Xn = zeros(net.Qin);
    net.MFQin = MFQin; % матрица функций принадлежности первого слоя сети
    net.Qout = Qout; % количество выходов сети
    net.MFparam = param;
    net.Mfnlayer = Mfnlayer(net.Qin, net.Xn, net.MFQin, net.MFparam);
    % 2 слой
    net.MlinkandQinMand = MlinkandQinMand; % матрица связей Qin входов и Mand нейронов во втором слое сети
    net.Mand = Mand; % количество операций И в правилах нечеткого вывода
    net.Andnlayer = Andnlayer(net.Mfnlayer.mfn,net.Mand, net.MlinkandQinMand)
    % 3 слой
    net.Mor = Mor; % количество операций ИЛИ в правилах
    net.MlinkorMandMor = MlinkorMandMor; % матрица связей Mand выходов И-нейронов и Mor ИЛИ-нейронов в третьем слое
    net.Ornlayer = Ornlayer(net.Andnlayer.output,net.Mor, net.MlinkorMandMor);
    % Создаем четвертый слой - слой нормализующих нейронов
    Mnorm = Mand * Mor; % количество нормализующих нейронов
    net.Mnorm = Mnorm; % сохраняем количество нормализующих нейронов в структуре
    net.Nnlayer = Nnlayer(net.Mnorm,net.Ornlayer.output,Mlinlnm);
    net.MFRQout = MFRQout; % матрица функций принадлежности выходного слоя
    % Возвращаем структуру, представляющую нейронную сеть ANFIS
end