% plot the first n clusters of a second_level_permutation_test 
% (independent of their significance)
%   stat    - struct that is computed by ft_freqstatistics (here, second_level_permutation_test)
%   n_clust - number of clusters that should be plotted (for each, positive and negative clusters)
function plot_permutation_clusters(stat, n_clust)
    
if nargin < 2
    n_clust = 0;
end

% plot the results
figure
cfg = [];
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
%cfg.zlim   = [-3 3];
cfg.interactive = 'yes';
if length(stat.label)<65
    cfg.layout = 'biosemi64.lay';
    cfg.channel='EEG';
else
if any([regexp(stat.label{1},'MEG0111'), regexp(stat.label{1},'MEG0621')])
cfg.layout = 'neuromag306mag.lay';
cfg.channel='MEGMAG';
else
cfg.layout = 'neuromag306cmb.lay';
cfg.channel='MEGGRAD';
end
end
cfg.comment = 'significant cluster(s)';
cfg.colorbar='yes';
ft_multiplotTFR(cfg, stat);

% positive clusters
if length(stat.posclusters) >= n_clust
    for i=1:n_clust
        stat.sig_cluster_mask = (stat.posclusterslabelmat == i);
        cfg.maskparameter = 'sig_cluster_mask';
        cfg.comment = ['positive cluster #' num2str(i) ' (p=' num2str(stat.posclusters(i).prob) ')'];
        figure;
        ft_multiplotTFR(cfg, stat);
    end
end

% negative clusters
if length(stat.negclusters) >= n_clust
    for j=1:n_clust
        stat.sig_cluster_mask = (stat.negclusterslabelmat == j);
        cfg.maskparameter = 'sig_cluster_mask';
        cfg.comment = ['negative cluster #' num2str(j) ' (p=' num2str(stat.negclusters(j).prob) ')'];
        figure;
        ft_multiplotTFR(cfg, stat);
    end
end

end